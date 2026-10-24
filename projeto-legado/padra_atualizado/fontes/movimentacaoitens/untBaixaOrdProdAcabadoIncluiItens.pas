unit untBaixaOrdProdAcabadoIncluiItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, Datasnap.DBClient, Uni,
  UniClientDataSet;

type
  TfrmBaixaOrdProdAcabadoIncluiItens = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    lblItemEntrada: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label14: TLabel;
    edtQtdIte: TEditFocus;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    procedure pInsereItem;

  public
    cdsItens: TUniClientDataSet;
    strSeqGer: String;
    blnConfirma: Boolean;
    blnManutencao: Boolean;

    { Public declarations }
  end;

var
  frmBaixaOrdProdAcabadoIncluiItens: TfrmBaixaOrdProdAcabadoIncluiItens;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmBaixaOrdProdAcabadoIncluiItens.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  If StrToFloat(edtQtdIte.Text) <= 0 Then
  begin
    pMensagemOk('A Quantidade deve ser maior que zero!');
    pSetFocus(edtQtdIte);
    blnConfirma := False;
  End;

  cdsItens.DisableControls;
  cdsItens.Filtered := False;
  cdsItens.Filter := 'CODITE = ' + QuotedStr(edtCodIte.Text);
  cdsItens.Filtered := True;

  If Not cdsItens.IsEmpty Then
  Begin
    pMensagemOk('O Item ja esta na ordem de produção!');
    edtCodIte.Text := '';
    pSetFocus(edtCodIte);
    blnConfirma := False;
  End;

  cdsItens.Filtered := False;
  cdsItens.Filter := '';
  cdsItens.EnableControls;

  If blnConfirma then
  begin
    pInsereItem;
    Close;
  End;
end;

procedure TfrmBaixaOrdProdAcabadoIncluiItens.pInsereItem;
  var
    qryItem: TUniQuery;
begin
  qryItem := fCriaQuery;
  Try
    qryItem.SQL.Add('SELECT G.ITE_CODITE AS CODITE,');
    qryItem.SQL.Add('       C.ITE_DESITE AS DESITE,');
    qryItem.SQL.Add('       UNI_SIGUNI AS SIGUNI,  ');
    qryItem.SQL.Add('       0.0000 AS QTDITE,      ');
    qryItem.SQL.Add('       ITE_PRECUS AS PRECUS,  ');
    qryItem.SQL.Add('       ITE_PREMED AS PREMED,  ');
    qryItem.SQL.Add('       ITE_REFERE AS REFERE   ');
    qryItem.SQL.Add('  FROM ITEGER G');
    qryItem.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE');
    qryItem.SQL.Add('  LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = ITE_CODUNI');
    qryItem.SQL.Add(' WHERE G.ITE_CODITE = "'+edtCodIte.Text+'"');
    qryItem.SQL.Add('   AND G.ITE_CODEMP = "'+VS_strCodEmp+'"');
    qryItem.Open;

    If Not qryItem.IsEmpty then
    Begin
      cdsItens.Append;
      cdsItens.FieldByName('AUTINC').Value :=  '';
      cdsItens.FieldByName('SEQGER').Value :=  strSeqGer;
      cdsItens.FieldByName('CODITE').Value :=  qryItem.FieldByName('CODITE').Value;
      cdsItens.FieldByName('DESITE').Value :=  qryItem.FieldByName('DESITE').Value;
      cdsItens.FieldByName('SIGUNI').Value :=  qryItem.FieldByName('SIGUNI').Value;
      cdsItens.FieldByName('REFERE').Value :=  qryItem.FieldByName('REFERE').Value;
      If blnManutencao Then
      Begin
        cdsItens.FieldByName('QTDARQ').Value := StrToFloat(edtQtdIte.Text);
        cdsItens.FieldByName('TOTBAI').Value := 0;
        cdsItens.FieldByName('QTDRES').Value := StrToFloat(edtQtdIte.Text);
        cdsItens.FieldByName('QTDITE').Value := StrToFloat(edtQtdIte.Text);
        cdsItens.FieldByName('QTDBAI').Value := 0;
        cdsItens.FieldByName('ITEMNOVO').Value := 'S';
      End
      Else
      Begin
        cdsItens.FieldByName('QTDITE').Value := StrToFloat(edtQtdIte.Text);
        cdsItens.FieldByName('QTDBAI').Value := StrToFloat(edtQtdIte.Text);
      End;
      cdsItens.FieldByName('PRECUS').Value :=  qryItem.FieldByName('PRECUS').Value;
      cdsItens.FieldByName('PREMED').Value :=  qryItem.FieldByName('PREMED').Value;
      cdsItens.Post;
    End;
  Finally
    FreeAndNil(qryItem)
  End;
End;


procedure TfrmBaixaOrdProdAcabadoIncluiItens.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If edtCodIte.Text <> '' Then
  begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
    If fEmptyStr(edtDesIte.Text) Then
    Begin
      pMensagemOk('Código do Item inválido!');
      edtCodIte.Text := '';
      pSetFocus(edtCodIte);
    End;

  End;

end;

procedure TfrmBaixaOrdProdAcabadoIncluiItens.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Produtos', '1') then
    Begin
      If edtCodIte.Text <> '' Then
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmBaixaOrdProdAcabadoIncluiItens.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodite.TamCampo := fTamCodIte;
  blnManutencao := False;
end;

end.
