import 'dart:async';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/common/utils/printer_util.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/extensions/string_extension.dart';

part 'print_event.dart';
part 'print_state.dart';

class PrintBloc extends BaseBloc<PrintEvent, PrintState> {
  PrintBloc() : super(PrintInitial()) {
    on<PrintExecuteEvent>(_onPrintExecuteEvent);
  }

  FutureOr<void> _onPrintExecuteEvent(
    PrintExecuteEvent event,
    Emitter<PrintState> emit,
  ) async {
    emit(PrintLoading());
    try {
      final printManager = PrinterUtil();
      await printManager.scan();
      await Future.delayed(
        const Duration(seconds: 1),
        () async {
          await printManager.startPrint(
            generateLineTexts(
              saleEntityList: event.saleEntityList,
              receiptEntity: event.receiptEntity,
              dateText: event.dateText,
              timeText: event.timeText,
              userName: event.userName,
            ),
          );
          emit(PrintSuccess());
        },
      );
    } catch (e) {
      emit(PrintFailed());
    }
  }

  List<LineText> generateLineTexts({
    required List<SaleEntity> saleEntityList,
    required ReceiptEntity receiptEntity,
    required String dateText,
    required String timeText,
    required String userName,
  }) {
    const maxCharsPerLine = 32;
    const separator = '-';

    final separatorLineText = LineText(
      type: LineText.TYPE_TEXT,
      content:
          List.generate(maxCharsPerLine, (index) => separator).toList().join(),
      weight: 0,
      align: LineText.ALIGN_CENTER,
      linefeed: 1,
    );

    String getSpaces(int textLength) {
      const space = ' ';
      final numberOfSpace = maxCharsPerLine - textLength;
      return List.generate(numberOfSpace, (index) => space).join();
    }

    String generateAlignBetween(String textContainsPipe) {
      const minSpace = 2;
      const maxLengthWithoutSpace = maxCharsPerLine - minSpace;
      const pipeChar = '|';
      final lengthWithoutPipe = textContainsPipe.length - 1;

      final splitted = textContainsPipe.split(pipeChar);
      if (splitted.length != 2) {
        throw Exception('splitted length should be 2. seems pipe char is '
            'there are more than one.');
      }

      if (lengthWithoutPipe > maxLengthWithoutSpace) {
        final leftText = splitted.first;
        final rightText = splitted.last;
        final availableSpace = maxLengthWithoutSpace - (rightText.length);
        final cuttedText = leftText.substring(0, availableSpace);
        splitted[0] = cuttedText;
      }

      final spaces = getSpaces(splitted.join().length);

      return splitted.join(spaces);
    }

    final listInList = saleEntityList
        .map(
          (e) => [
            LineText(
              type: LineText.TYPE_TEXT,
              content: generateAlignBetween(
                '${e.productEntity.name}|'
                '${e.productEntity.saleNet.toString().toRupiahCurrency()}',
              ),
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            ),
            LineText(
              type: LineText.TYPE_TEXT,
              content: '   ${e.total} X      '
                  '${e.productEntity.saleNet.toString().toRupiahCurrency()}',
              align: LineText.ALIGN_LEFT,
              linefeed: 1,
            ),
          ],
        )
        .toList();

    final listLineText =
        listInList.fold(<LineText>[], (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    });

    final List<LineText> list = [
      // TODO(melly): enhance hardcoded string and get from state
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Toko Adi Jaya Sembako',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content:
            'Jembatan 14, RT.001/RW.005, Bojong Rawalumbu, Kec. Rawalumbu, Kota Bks, Jawa Barat',
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: '081234567890',
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      separatorLineText,
      ...listLineText,
      separatorLineText,
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween(
          'Total|${receiptEntity.totalNet.toString().toRupiahCurrency()}',
        ),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        weight: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween(
          'Bayar|${receiptEntity.cash.toString().toRupiahCurrency()}',
        ),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween(
          'Kembali|${receiptEntity.change.toString().toRupiahCurrency()}',
        ),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      separatorLineText,
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tanggal Transaksi',
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: dateText,
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        weight: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('Waktu|Kasir'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('$timeText|$userName'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        weight: 1,
      ),
    ];

    return list;
  }
}
