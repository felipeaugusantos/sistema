unit untIZClient;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  UniClientDataset,
{$ENDIF LINUX}
  DB, Uni;

Type
  IZClient = interface
  ['{14847D97-80B5-4095-862D-23FB2787D039}']
    function fSalva: Boolean;
    function fRetSoma(strNomAgg: String): Double;
    function fAbreClient(blnSetProvider: Boolean = False; strNomFunc: String = '';
                         blnRefresh: Boolean = False; blnExibirProgresso : Boolean = False): Boolean;

    function IsEmpty: Boolean;
    function FieldByName(const FieldName: string): TField;
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;

    procedure Open;
    procedure Close;
    procedure DisableControls;
    procedure EnableControls;
    procedure Insert;
    procedure Append;
    procedure Edit;
    procedure Post;
    procedure First;
    procedure Next;
    procedure EmptyDataSet;
    procedure Delete;

    procedure pCancela(blnUpdates: Boolean = True);
    procedure pSetProvider;
    procedure pCriaSoma(strNomCam: String; strNomAgg: String = ''; strFormula: String = '');
    procedure pSalvaPorRegistro(strNomTab, strCamCod: String);
    procedure pFormataDecimal(strNomCam: String; intNumDec: Integer = 2);
    Procedure pLimpaDados(strChave: String = '');
    Procedure pAlinhaCampoCentro(strNomCam: String);

    function fGetDataset: TDataset;
    function fGetUniClientDataset: TUniClientDataset;

    function fGetQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
    procedure pSetQuery(Dataset: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF});

    function fGetSource: TDataSource;
    procedure pSetSource(DataSource: TDataSource);

    function fGetMsgErr: String;

    function fGetFiltered: Boolean;
    procedure pSetFiltered(Value: Boolean);

    function fGetFilter: String;
    procedure pSetFilter(Value: String);

    function fGetData: OleVariant;
    procedure pSetData(Value: OleVariant);

    function fGetIndexFieldNames: String;
    procedure pSetIndexFieldNames(Value: String);

    function fGetAfterScroll: TDataSetNotifyEvent;
    procedure pSetAfterScroll (Value: TDataSetNotifyEvent);

    function GetRecordCount: Integer;

    function GetRecNo: Integer;
    procedure SetRecNo(Value: Integer);

    function fGetFFields: TFields;
    function fGetFEOF: Boolean;

    function fExportaCSV(strNomCSV : String):Boolean;
    Procedure pSetUpdateMode(enuUpdateMode : TUpdateMode);

    property qryQuery : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF}      Read fGetQuery  Write pSetQuery;
    property dtsSource: TDataSource    Read fGetSource Write pSetSource;
    property strMsgErr: String         Read fGetMsgErr;
    property Filtered: Boolean         Read fGetFiltered Write pSetFiltered;
    property Filter: string            Read fGetFilter   Write pSetFilter;
    property Data: OleVariant          Read fGetData     Write pSetData;
    property IndexFieldNames: string   Read fGetIndexFieldNames Write pSetIndexFieldNames;
    property RecordCount: Integer      Read GetRecordCount;
    property RecNo: Integer            Read GetRecNo Write SetRecNo;
    property Fields: TFields           Read fGetFFields;
    property Eof: Boolean              Read fGetFEOF;
    property AfterScroll: TDataSetNotifyEvent read fGetAfterScroll write pSetAfterScroll;
  End;

implementation

end.
