unit untModuloRetBco;

interface

uses
  SysUtils, Classes, DB, Uni, MemDS, DBAccess, frxclass;

type
  TfrmModuloRetBco = class(TDataModule)
    qryRetBco: TUniQuery;
    dtsRetBco: TDataSource;
    qryRetBcoRET_CODBCO: TStringField;
    qryRetBcoRET_CODEMP: TStringField;
    qryRetBcoRET_CODCLI: TStringField;
    qryRetBcoRET_CODOCO: TStringField;
    qryRetBcoRET_DTAOCO: TDateField;
    qryRetBcoRET_NUMDUP: TStringField;
    qryRetBcoRET_PARCEL: TStringField;
    qryRetBcoRET_ESPDOC: TStringField;
    qryRetBcoRET_NOSNUM: TStringField;
    qryRetBcoRET_DTAPAG: TDateField;
    qryRetBcoRET_VALPAG: TFloatField;
    qryRetBcoRET_DESCON: TFloatField;
    qryRetBcoRET_JURMOR: TFloatField;
    qryRetBcoRET_DTAVEN: TDateField;
    qryRetBcoRET_VALDUP: TFloatField;
    qryRetBcoRET_NOMARQ: TStringField;
    qryRetBcoRET_CODREJ: TStringField;
    qryRetBcoRET_MOTOCO: TStringField;
    qryRetBcoRET_DTAARQ: TDateField;
    qryRetBcoRET_HORARQ: TTimeField;
    qryRetBcoRET_CARTEI: TIntegerField;
    qryRetBcoRET_CONRET: TStringField;
    qryRetBcoRET_OUTCOB: TFloatField;
    qryRetBcoRET_DUPBAI: TStringField;
    qryRetBcoRET_DUPDIV: TStringField;
    qryRetBcoRET_MOTDIV: TStringField;
    qryRetBcoRET_DTACRE: TDateField;
    qryRetBcoRET_OUTVAL: TFloatField;
    qryRetBcoRET_TARIFA: TFloatField;
    qryRetBcoRET_VALLAN: TFloatField;
    qryRetBcoRET_CUSCAR: TFloatField;
    qryRetBcoRET_CARBCO: TStringField;
    qryRetBcoRET_IOFDES: TFloatField;
    qryRetBcoRET_TXADES: TFloatField;
    qryRetBcoRET_DUPDES: TStringField;
    qryRetBcoRET_JUROPE: TFloatField;
    qryRetBcoRET_CNAB__: TStringField;
    qryRetBcoRET_TARTED: TFloatField;
    qryRetBcoRET_RECPIX: TStringField;
    qryRetBcoRET_END_ID: TStringField;
    qryRetBcoRET_EMPIMP: TStringField;
    qryRetBcoRET_ERRPIX: TStringField;
    qryRetBcoRET_QRCODE: TMemoField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloRetBco: TfrmModuloRetBco;

implementation

{$R *.dfm}

procedure TfrmModuloRetBco.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

end;

end.
