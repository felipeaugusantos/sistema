unit untSituacaoItensPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, cxProgressbar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, MemDS, DBAccess, Uni, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  UniClientDataSet;

type
  TfrmSituacaoItensPedido = class(TfrmPai)
    DBGridCitel1: TDBGridCitel;
    dtsItens: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qrySituacao: TUniQuery;
    cdsSituacao: TUniClientDataSet;
    procedure pCarregarItens();
    function fAtualizarStatusItens(cxProgress: TcxProgressbar): Boolean;
  public
    { Public declarations }
    strNumDoc,
    strEspDoc,
    strCodEmp: string;
  end;

var
  frmSituacaoItensPedido: TfrmSituacaoItensPedido;

implementation

uses
  untFuncoesSimples, untTSituacaoPedidoVenda;

{$R *.dfm}

{ TfrmSituacaoItensPedido }

procedure TfrmSituacaoItensPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Assigned(qrySituacao)) then
    FreeAndNil(qrySituacao);
  if (Assigned(cdsSituacao)) then
    FreeAndNil(cdsSituacao);
  inherited;
end;

procedure TfrmSituacaoItensPedido.FormShow(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(strNumDoc)) and (not fEmptyStr(strEspDoc)) and (not fEmptyStr(strCodEmp)) then
  begin
    fExecutarModal(pCarregarItens , 'Aguarde, carregando produtos ...', '');
    fChamaTelaGravando(fAtualizarStatusItens, 'Aguarde, verificando status dos produtos ...');
  end;
end;

function TfrmSituacaoItensPedido.fAtualizarStatusItens(cxProgress: TcxProgressbar): Boolean;
Var
  LCodIte: String;
  LSeqFdo: String;
  LStatus: String;
begin
  cxProgress.Properties.Max := cdsSituacao.Recordcount;

  cdsSituacao.First;
  While Not cdsSituacao.Eof Do
  Begin
    cdsSituacao.Edit;

    For LSeqFdo In cdsSituacao.FieldByName('SEQFDO').AsString.Split([',']) Do
    Begin
      LStatus := TStatus.New(
        TParamStatus.New()
          .NumDoc(strNumDoc)
          .EspDoc(strEspDoc)
          .CodEmp(strCodEmp)
          .SeqFdo(LSeqFdo)
      ).fGetStatus().fGetDescricao;

      LCodIte := cdsSituacao.FieldByName('CODITE').AsString;

      If LStatus.Equals(pvSeparando.fGetDescricao) Then
        If TVerificarStatusSeparacaoConcluidaItem.CheckStatus(strNumDoc, strEspDoc, strCodEmp, LCodIte) Then
          LStatus := TVerificarStatusSeparacaoConcluidaItem.strSeparacaoConcluidaItem;

      If Not cdsSituacao.FieldByName('STATUS').AsString.Contains(LStatus) Then
      Begin
        If cdsSituacao.FieldByName('STATUS').AsString.IsEmpty Then
          cdsSituacao.FieldByName('STATUS').AsString := LStatus
        Else
          cdsSituacao.FieldByName('STATUS').AsString :=
            cdsSituacao.FieldByName('STATUS').AsString + ', ' + LStatus;
      End;
    End;

    cdsSituacao.Post;
    cdsSituacao.Next;

    cxProgress.Position := cdsSituacao.RecNo;
    Application.ProcessMessages;
  End;
  cdsSituacao.First;

  Result := True;
end;

procedure TfrmSituacaoItensPedido.pCarregarItens();
begin
  qrySituacao := fCriaQuery;
  qrySituacao.Close;
  qrySituacao.SQL.Clear;
  qrySituacao.SQL.Add('  SELECT ');
  qrySituacao.SQL.Add('    FDO_CODITE AS CODITE, ');
  qrySituacao.SQL.Add('    FDO_DESCRI AS DESITE, ');
  qrySituacao.SQL.Add('    UNI_SIGUNI AS CODUNI, ');
  qrySituacao.SQL.Add('    SUM(IF(FDO_JAFATU = 1 AND FDO_QTDBAI > 0, FDO_QTDBAI, FDO_QTDITE - FDO_QTDBAI)) AS QTDITE, ');
  qrySituacao.SQL.Add('    CAST("" AS CHAR(500)) AS STATUS, ');
  qrySituacao.SQL.Add('    GROUP_CONCAT(DISTINCT FDO_SEQFDO) AS SEQFDO ');
  qrySituacao.SQL.Add('  FROM ');
  qrySituacao.SQL.Add('    FATDOR ');
  qrySituacao.SQL.Add('    INNER JOIN EXTDOR ');
  qrySituacao.SQL.Add('      ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
  qrySituacao.SQL.Add('    LEFT JOIN CADUNI ');
  qrySituacao.SQL.Add('      ON UNI_CODUNI = FDO_UNIDAD ');
  qrySituacao.SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC ');
  qrySituacao.SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
  qrySituacao.SQL.Add('    AND FDO_CODEMP = :CODEMP ');
  qrySituacao.SQL.Add('  GROUP BY FDO_CODITE, ');
  qrySituacao.SQL.Add('    FDO_DESCRI, ');
  qrySituacao.SQL.Add('    UNI_SIGUNI  ');

  qrySituacao.ParamByName('NUMDOC').AsString := strNumDoc;
  qrySituacao.ParamByName('ESPDOC').AsString := strEspDoc;
  qrySituacao.ParamByName('CODEMP').AsString := strCodEmp;

  qrySituacao.Open;

  cdsSituacao := fCriaClientDatset(qrySituacao);

  dtsItens.DataSet := cdsSituacao;
end;

end.
