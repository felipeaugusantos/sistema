unit untFatLimparSeparacaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, untPai, Datasnap.DBClient, UniClientDataSet;

type
  TfrmFatLimparSeparacaoPedido = class(TfrmPai)
    pnlCabecalhoPrincipal: TPanel;
    lblPedido: TLabel;
    edtNumDoc: TEditFocus;
    btnConsultar: TBitBtnLocked;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDadosPedido: TPanel;
    lblDtaEmissao: TLabel;
    lblCliente: TLabel;
    lblVendedor: TLabel;
    lblVlrContabil: TLabel;
    dbgItensPedido: TDBGridCitel;
    edtDtaEmissao: TEditFocus;
    edtCliente: TEditFocus;
    edtVendedor: TEditFocus;
    edtVlrContabil: TEditFocus;
    btnLimparSeparacao: TBitBtnLocked;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    cdsItensCODITE: TStringField;
    cdsItensDESCRICAO: TStringField;
    cdsItensQUANTIDADE: TFloatField;
    cdsItensUNIDADE: TStringField;
    cdsItensAUTO_FATGOR: TStringField;
    procedure btnConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimparSeparacaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pConsultar;
    procedure pLimparTela;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untGravando,
  untFatGor,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatLimparSeparacaoPedido.btnConsultarClick(Sender: TObject);
  Var
    frmGravando : TfrmGravando;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarModal(pConsultar, 'Aguarde... Consultando os dados do pedido!', '');
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatLimparSeparacaoPedido.pConsultar;
  Var
    qryGen : TUniQuery;
begin
  If Not cdsItens.Active then
  begin
    cdsItens.CreateDataSet;
    cdsItens.Open;
  end;

  pLimparTela;

  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT DISTINCT');
    qryGen.SQL.Add('   FATGOR.AUTOINCREM, FGO_DTAENT, FGO_SEPIMP, ');
    qryGen.SQL.Add('   FGO_VLRCON, FGO_CODCLI, FGO_CODVEN, ');
    qryGen.SQL.Add('   FGO_JAFATU, FGO_MOTBAI, FGO_NUMFAT, ');
    qryGen.SQL.Add('   FGO_TIPFAT, FGO_EMPFAT, LOTDOR.* ');
    qryGen.SQL.Add(' FROM FATGOR     ');
    qryGen.SQL.Add(' INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM  ');
    qryGen.SQL.Add(' LEFT  JOIN LOTDOR ON LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM  ');
    qryGen.SQL.Add(' WHERE FATGOR.FGO_NUMDOC = :NUMDOC  ');
    qryGen.SQL.Add('   AND FATGOR.FGO_ESPDOC = :ESPDOC  ');
    qryGen.SQL.Add('   AND FATGOR.FGO_CODEMP = :CODEMP  ');
    qryGen.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryGen.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryGen.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryGen.Open;

    btnLimparSeparacao.Enabled := Not qryGen.IsEmpty;
    If qryGen.IsEmpty Then
    Begin
      pMensagemOk('Pedido não encontrado!');
      Exit;
    End;

    If qryGen.FieldByName('FGO_JAFATU').AsString = '1' Then
    Begin
      If fEmptyStr(qryGen.FieldByName('FGO_MOTBAI').AsString) Then
        pMensagemOk('Este pedido já foi faturado no documento '+
                     Concat(qryGen.FieldByName('FGO_NUMFAT').AsString, '-',
                           qryGen.FieldByName('FGO_TIPFAT').AsString, '-',
                           qryGen.FieldByName('FGO_EMPFAT').AsString)+'!')
      Else
        pMensagemOk('Este pedido já foi baixado que não será mais entregue!');

      Exit;
    End;

    If StrToIntDef(qryGen.FieldByName('FGO_SEPIMP').AsString, 0) <= 0 Then
    Begin
      pMensagemOk('Este pedido não está em separação!');
      Exit;
    End;

    edtDtaEmissao.Text  := qryGen.FieldByName('FGO_DTAENT').AsString;
    edtVlrContabil.Text := FormatFloat('#,##0.00', qryGen.FieldByName('FGO_VLRCON').AsFloat);
    edtCliente.Text     := qryGen.FieldByName('FGO_CODCLI').AsString + '-' + fRetNomCliente(qryGen.FieldByName('FGO_CODCLI').AsString);
    edtVendedor.Text    := qryGen.FieldByName('FGO_CODVEN').AsString + '-' + fRetNomVendRep(qryGen.FieldByName('FGO_CODVEN').AsString);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('   FDO_SEQGER AS AUTO_FATGOR, ');
    qryGen.SQL.Add('   FDO_CODITE AS CODITE, ');
    qryGen.SQL.Add('   ITE_DESITE AS DESITE, ');
    qryGen.SQL.Add('   FDO_QTDITE AS QTDITE, ');
    qryGen.SQL.Add('   UNI_DESUNI AS DESUNI ');
    qryGen.SQL.Add(' FROM FATDOR ');
    qryGen.SQL.Add('   INNER JOIN CADITE ON FDO_CODITE = ITE_CODITE ');
    qryGen.SQL.Add('   INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryGen.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC ');
    qryGen.SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
    qryGen.SQL.Add('   AND FDO_CODEMP = :CODEMP ');
    qryGen.SQL.Add(' ORDER BY ITE_DESITE ASC ');
    qryGen.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryGen.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryGen.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryGen.Open;

    qryGen.first;
    While Not qryGen.Eof Do
    Begin
      cdsItens.Append;
      cdsItensAUTO_FATGOR.AsString := qryGen.FieldByName('AUTO_FATGOR').AsString;
      cdsItensCODITE.AsString      := qryGen.FieldByName('CODITE').AsString;
      cdsItensDESCRICAO.AsString   := qryGen.FieldByName('DESITE').AsString;
      cdsItensQUANTIDADE.AsFloat   := qryGen.FieldByName('QTDITE').AsFloat;
      cdsItensUNIDADE.AsString     := qryGen.FieldByName('DESUNI').AsString;
      cdsItens.Post;

      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatLimparSeparacaoPedido.btnLimparSeparacaoClick(Sender: TObject);
begin
  inherited;
  If fLimpaExpedicaoPedido(cdsItensAUTO_FATGOR.AsString) Then
  Begin
    pMensagemOk('Operação realizada com sucesso!');
    pLimparTela;
  End;
end;

procedure TfrmFatLimparSeparacaoPedido.pLimparTela;
begin
  btnLimparSeparacao.Enabled := False;

  edtDtaEmissao.Clear;
  edtVlrContabil.Clear;
  edtCliente.Clear;
  edtVendedor.Clear;

  If cdsItens.Active then
    cdsItens.EmptyDataSet;
end;

procedure TfrmFatLimparSeparacaoPedido.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
  pSetFocus(edtCodEmp);
end;

function TfrmFatLimparSeparacaoPedido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        pMensagemOk('Código da empresa deve ser preenchido!');
        Result := False;
      End
      Else If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If fEmptyStr(edtDesEmp.Text)  Then
        Begin
          pMensagemOk('Código da empresa não encontrado.');
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          pMensagemOk('Usuário sem permissão de acesso a essa Empresa!');
          Result := False;
        End;
      End
    End
    Else If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        pMensagemOk('Número do pedido deve ser preenchido!');
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
