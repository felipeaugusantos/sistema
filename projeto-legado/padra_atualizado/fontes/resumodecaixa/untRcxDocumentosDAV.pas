unit untRcxDocumentosDAV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  DB,  Uni, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmRcxDocumentosDAV = class(TfrmPai)
    dbgDocumentos: TDBGridCitel;
    Label1: TLabel;
    qryDocumentos: TUniQuery;
    dtsDocumentos: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    intSemaforoImpressao: Integer;
    procedure pCarregarDocumentos;
    procedure pImprimirDocumento;
    procedure pMarcarDocumentoComoImpresso(strNumDoc, strEspDoc: String);
  public
    { Public declarations }
    strEspDoc: String;
  end;

var
  frmRcxDocumentosDAV: TfrmRcxDocumentosDAV;

implementation

uses untFuncoesSimples, untQckDAV, untFiscal;

{$R *.dfm}

{ TfrmRcxDocumentosDAV }

procedure TfrmRcxDocumentosDAV.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click
  Else If Key = VK_RETURN Then
  Begin
    Try
      If (InterlockedIncrement(intSemaforoImpressao) = 0) Then
      Begin
        pImprimirDocumento;
        InterlockedDecrement(intSemaforoImpressao);
      End
      Else
        InterlockedDecrement(intSemaforoImpressao);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoImpressao);
        pMensagensErro(E.Message, '[dbgDocumentosKeyDown]');
      End;
    End;
  End;
end;

procedure TfrmRcxDocumentosDAV.FormCreate(Sender: TObject);
begin
  inherited;
  intSemaforoImpressao := -1;
end;

procedure TfrmRcxDocumentosDAV.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarDocumentos;
end;

procedure TfrmRcxDocumentosDAV.pCarregarDocumentos;
begin
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add('SELECT ');
  qryDocumentos.SQL.Add('  FGO_NUMDOC, ');
  qryDocumentos.SQL.Add('  FGO_ESPDOC, ');
  qryDocumentos.SQL.Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", FGO_NOMCON, CLI_NOMCLI) AS FGO_NOMCLI, ');
  qryDocumentos.SQL.Add('  FGO_VLRCON ');
  qryDocumentos.SQL.Add('FROM ');
  qryDocumentos.SQL.Add('  FATGOR ');
  qryDocumentos.SQL.Add('  INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
  qryDocumentos.SQL.Add('WHERE ');
  qryDocumentos.SQL.Add('  FGO_IMPDAV = FALSE ');

  If Not fEmptyStr(strEspDoc) Then
  Begin
    qryDocumentos.SQL.Add('  AND FGO_ESPDOC = :ESPDOC ');
    qryDocumentos.ParamByName('ESPDOC').AsString := strEspDoc;
  End;

  qryDocumentos.Open;

  TFloatField(qryDocumentos.FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';
end;

procedure TfrmRcxDocumentosDAV.pImprimirDocumento;
  Var
    frmQck: TfrmQckDAV;
begin
  If Not Assigned(VS_objFiscal) Then
  Begin
    fMensagem('ATENÇÃO!', 'A impressora fiscal está configurada incorretamente.', ['&Ok']);
    Exit;
  End;

  If qryDocumentos.IsEmpty Then
  Begin
    Exit;
  End;

  frmQck := TfrmQckDAV.Create(Self);
  frmQck.pImprimirDAVECF(qryDocumentos.FieldByName('FGO_NUMDOC').AsString,
                         qryDocumentos.FieldByName('FGO_ESPDOC').AsString);
  FreeAndNil(frmQck);

  pMarcarDocumentoComoImpresso(qryDocumentos.FieldByName('FGO_NUMDOC').AsString,
                               qryDocumentos.FieldByName('FGO_ESPDOC').AsString);

  pCarregarDocumentos;
end;

procedure TfrmRcxDocumentosDAV.pMarcarDocumentoComoImpresso(strNumDoc, strEspDoc: String);
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  FATGOR ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  FGO_IMPDAV = TRUE ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
  qryUpd.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
  qryUpd.SQL.Add('  FGO_CODEMP = :CODEMP ');

  qryUpd.ParamByName('NUMDOC').AsString := strNumDoc;
  qryUpd.ParamByName('ESPDOC').AsString := strEspDoc;
  qryUpd.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

end.
