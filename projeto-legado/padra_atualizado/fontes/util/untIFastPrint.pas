unit untIFastPrint;

interface

uses Classes, frxClass, untTypesSistema, System.Generics.Collections;

Type
  IFastPrintFile = interface
  ['{185EBDC7-7A9A-4F53-8739-FAC37CC3B4CB}']
    function  fGetIsEmpty: Boolean;
    function fGetKey: String;
    function fGetName: String;
    function fGetDBDataSets: TArrFrxDBDataSet;
    function fGetUserDataSets: TArrFrxUserDataSet;
    function fGetFunctionsList: TStringList;
    function fGetVariables: TDictionary<String,Variant>;
    function fGetUserFunction: TfrxUserFunctionEvent;
    function fPrepareDataSetsAndVariables: Boolean;
    function fGetPrinterName: String;
    function fGetFastType: TFastFileType;
    procedure pConfigTypeAndPrinterName;

    property IsEmpty: Boolean read fGetIsEmpty;
  End;

  IFastPrintFileEditor = interface
  ['{E1CFE699-171E-482F-B8CD-6E3CAF0095CD}']
      procedure pSetFastPrintFile(iFastFile: IFastPrintFile);
      procedure pSelectFil(strNomPro, strNomFil, strNomeRede: String);

      function fLoadReport: Boolean;
      function fSaveReport: Boolean;
      function fChanged: Boolean;

      procedure pEditLayout;
      procedure pPreview;
      procedure pExport;
      procedure pImport;
      procedure pPrint;
      procedure pConfigPrinter;
  End;

implementation

end.

