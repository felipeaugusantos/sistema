unit untSolicitacaodeReposicaodeGondola;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni, math, untCadLote,
  Datasnap.DBClient, untZClient, Vcl.ComCtrls, cxContainer, cxProgressBar,
  cxCurrencyEdit, untPai, strUtils;

type
  TfrmSolicitacaodeReposicaodeGondola = class(TfrmPai)
    pnlItens: TPanel;
    lblItemEntrada: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblSaldoDisponivel: TLabel;
    edtSaldoDisponivel: TEditFocus;
    Label11: TLabel;
    edtSaldos: TEditFocus;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    pnlOperador: TPanel;
    Label5: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    Label1: TLabel;
    edtMarca: TEditFocus;
    Label2: TLabel;
    edtSigUni: TEditFocus;
    Label4: TLabel;
    edtObservacao: TEditFocus;
    btnIncluir: TBitBtnLocked;
    pnlGrid: TPanel;
    cxgItens: TcxGridDBTableViewCitel;
    cxlItens: TcxGridLevel;
    cxItens: TcxGridCitel;
    Panel4: TPanel;
    btnLimpar: TBitBtnLocked;
    lblQuantidade: TLabel;
    edtQtdIte: TEditFocus;
    Label6: TLabel;
    edtSaldoLote: TEditFocus;
    Label7: TLabel;
    edtSaldoLoteDisponivel: TEditFocus;
    dtsDados: TDataSource;
    cxgItensSOL_CODITE: TcxGridDBColumn;
    cxgItensITE_DESITE: TcxGridDBColumn;
    cxgItensSOL_QTDITE: TcxGridDBColumn;
    cxgItensSOL_LOCFIS: TcxGridDBColumn;
    cxgItensSOL_NUMLOT: TcxGridDBColumn;
    cxgItensSOL_OBSERV: TcxGridDBColumn;
    Label9: TLabel;
    lblSolicitacaoPendente: TLabel;
    btnConfirma: TBitBtnLocked;
    btnMostraEstoque: TBitBtnLocked;
    Label3: TLabel;
    edtLocFis: TEditFocus;

    procedure btnLimparClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure pInsereRegistro;
    procedure btnConfirmaClick(Sender: TObject);
    procedure pReiniciaTela;
    procedure cxgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMostraEstoqueClick(Sender: TObject);
  private
    qryItem: TUniQuery;
    qryCadLot: TUniQuery;
    qryConsulta: TUniQuery;
    intDecQtd: integer;
    mskSaldo: String;
    strCodOperador: String;
    strLocFisOrigem: String;

    cdsSOLGON: TZClient;
    procedure pLimparCampos;
    procedure pLimparCamposLote;
    procedure pDeleteItem;
    procedure pLiberaProcesso;

    function fCarregaItem(ACodIte: String; blnBuscaPorChave: Boolean): Boolean;
    procedure pCarregaItemCDS;
    function fGravarSolicitacao(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fCarregaLote(ACodIte, ANumLot: String; blnBuscaPorChave: Boolean): Boolean;
    procedure pCarregaSolictacaoPendente(ACodIte, ANumLot, ALocFis: String);
    procedure pMostraEstoqueLojas;


    { Private declarations }
  protected


    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fTratavazio(AValue: String): String;
    function fValidaQuantidade(AQtdIte: Double; ASalDis: Double): Boolean;


  public
    { Public declarations }
  end;

var
  frmSolicitacaodeReposicaodeGondola: TfrmSolicitacaodeReposicaodeGondola;

implementation

uses
  untFuncoesSimples, untConsultas, untConstantes, untFuncoesConsulta,
  untTypesSistema, untGravando, untFatMostraEstoqueEmp;

{$R *.dfm}

procedure TfrmSolicitacaodeReposicaodeGondola.btnConfirmaClick(Sender: TObject);
var frmGravando: TFrmGravando;
begin
  inherited;
  If Not cdsSOLGON.IsEmpty Then
  begin
    If fPergunta('Gravar as solicitações de Reposição da Gôndola?') Then
    begin
      pCriarFormularios(TfrmGravando, frmGravando);
      try
        Try
          frmGravando.lblGravando.Caption := 'Gravando dados...';
          frmGravando.pgbStatus.Visible := False;
          frmGravando.fExecutarAcao := fGravarSolicitacao;
          frmGravando.ShowModal;
          If frmGravando.blnConfirma Then
          begin
            pMensagemOk('Gravação realizada com sucesso!');
            pReiniciaTela;
          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;
      Finally
        pFreeAndNil(frmGravando);
      End;
    End;

  end;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  begin
    pInsereRegistro;
    btnConfirma.Enabled := Not cdsSOLGON.IsEmpty;
    lblSolicitacaoPendente.Caption := '';

  End;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.btnLimparClick(Sender: TObject);
begin
  inherited;
  pLimparCampos;
  pSetFocus(edtCodIte);
  lblSolicitacaoPendente.Caption := '';

end;

procedure TfrmSolicitacaodeReposicaodeGondola.btnMostraEstoqueClick(
  Sender: TObject);
begin
  inherited;
  If btnMostraEstoque.Visible Then
  Begin
    if (not fVerificaAcessoSistema('PVISPF')) then
    begin
      fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de saldo de produtos no faturamento.',['&OK']);
      Exit;
    end;

    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
    Else
      pMostraEstoqueLojas;
  End;

end;

procedure TfrmSolicitacaodeReposicaodeGondola.pMostraEstoqueLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  If cdsSOLGON.IsEmpty Then
    Exit;
  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    Try
      frmFatMostraEstoqueEmp.blnFaturamento := True;
      frmFatMostraEstoqueEmp.strCodIte      := cdsSOLGON.FieldByName('SOL_CODITE').AsString;
      frmFatMostraEstoqueEmp.strTabPre      := '';
      frmFatMostraEstoqueEmp.edtItem.Text   := cdsSOLGON.FieldByName('SOL_CODITE').AsString + ' - ' +
                                               cdsSOLGON.FieldByName('ITE_DESITE').AsString;
      frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(cdsSOLGON.FieldByName('SOL_CODITE').AsString);
      frmFatMostraEstoqueEmp.showModal;
    Finally
      pFreeAndNil(frmFatMostraEstoqueEmp);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmSolicitacaodeReposicaodeGondola.pMostraEstoqueLojas]');
  End;

end;


procedure TfrmSolicitacaodeReposicaodeGondola.cxgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_dELETE : pDeleteItem;
    VK_RETURN : Begin
                  pCarregaItemCDS;
                  pSetFocus(edtLocFis);
                End;
  End;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.edtCodIteKeyPress(Sender: TObject; var Key: Char);
var arrProduto: TConsultasArray;
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodIte, True);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSolicitacaodeReposicaodeGondola.edtNumLotKeyPress(Sender: TObject; var Key: Char);
var arrLotes: TConsultasArray;
begin
  If fPesqLoteItens(Self,
                    edtNumLot,
                    nil,
                    fCfgSis('DECUNI', varInteger),
                    nil,
                    Key,
                    arrLotes,
                    True,
                    edtCodIte.Text,
                    VS_strCodEmp,
                    True,
                    False,
                    nil,
                    False,
                    False,
                    False) Then
  Begin
     If fValidaCampos(edtNumLot, True) Then
       Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSolicitacaodeReposicaodeGondola.FormCreate(Sender: TObject);
begin
  inherited;
  strCodOperador := '';
  qryItem := fCriaQuery(Self);
  qryConsulta := fCriaQuery(Self);
  qryCadLot := fCriaQuery(Self);
  intDecQtd := Max(3, fCfgSis('DECQTD', varInteger));
  mskSaldo := fMskDigitos(intDecQtd);
  edtCodIte.MaxLength := fTamCodIte;
  edtCodIte.TamCampo:= fTamCodIte;
  cdsSOLGON := TZClient.Create(Self, 'SELECT  SOLGON.*, CAST("" AS CHAR(100))ITE_DESITE FROM SOLGON WHERE FALSE');
  cdsSOLGON.fAbreClient(False, '[TfrmSolicitacaodeReposicaodeGondola.FormCreate]');
  dtsDados.DataSet := cdsSOLGON;
  TcxCurrencyEditProperties(cxgItensSOL_QTDITE.Properties).DisplayFormat := fMskDigitos(intDecQtd);;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F11: btnLimpar.Click;
    VK_f10: btnIncluir.Click;
    VK_F6: btnMostraEstoque.Click;
  End;

end;

function TfrmSolicitacaodeReposicaodeGondola.fTratavazio(
  AValue: String): String;
begin
  Result := AValue;
  If fEmptyStr(AValue) Then
    Result := '0';
end;

function TfrmSolicitacaodeReposicaodeGondola.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin
    If Sender = edtCodOpe then
    begin
      //Se não usa digitador então o campo de comprador está por senha
      strCodOperador := fRetCodVendedor(edtCodOpe.Text);
      If fEmptyStr(strCodOperador) Then
      begin
        pMensagemOk('Senha do operador inválida.');
        Result := false;
        edtCodOpe.Clear;
      end
      Else
      Begin
        edtNomOpe.Text := fRetNomVendRep(strCodOperador);
        pLiberaProcesso;
      End;
    end

    Else If Sender = edtCodIte then
    begin
      If fEmptyStr(edtCodIte.Text) Then
      begin
        pMensagemOk('O produto deve ser informado!');
        Result := false;
      End
      Else
      Begin
        If blnBuscaPorChave And cdsSOLGON.Locate('SOL_CODITE', edtCodIte.Text, []) Then
        Begin
          pCarregaItemCDS;
          blnMudarFoco := False;
          pSetFocus(edtLocFis);
        End
        Else
          Result := fCarregaItem(edtCodIte.Text, blnBuscaPorChave);
      End;
    End

    Else If Sender = edtLocFis Then
    begin
      If blnBuscaPorChave Then
        pCarregaSolictacaoPendente(edtCodIte.Text, edtNumLot.Text, edtLocFis.Text)
    End

    Else If Sender = edtNumLot then
    begin
      If edtNumLot.Enabled Then
      Begin
        If fEmptyStr(edtNumLot.Text) Then
        Begin
          Result := false;
          pMensagemOk('O Lote deve ser informado!');
        End
        Else
        Begin

          If (Not fEmptyStr(edtNumLot.Text))  Then
            Result := fCarregaLote(edtCodIte.Text, edtNumLot.Text, blnBuscaPorChave);
          If Result and  blnBuscaPorChave Then
            pCarregaSolictacaoPendente(edtCodIte.Text, edtNumLot.Text, edtLocFis.Text);
        End;
      End;
    End
    Else If Sender = edtQtdIte Then
    Begin
      If edtQtdIte.Text = '' Then
        edtQtdIte.Text := '0,00';
      Result := fValidaQuantidade(fstrToFloat(edtQtdIte.Text),
                                  fstrToFloat(edtSaldoDisponivel.Text) - fstrToFloat(fTratavazio(edtSaldoLoteDisponivel.Text)));
      If Result Then
      begin
        edtQtdIte.Text := FormatFloat(mskSaldo, fstrToFloat(edtQtdIte.Text));
      End;
    End;

    If (Sender = edtNumLot) And (Not blnBuscaPorChave) then
    begin
      If fEmptyStr(edtLocFis.Text) And
         fEmptyStr(edtNumLot.Text) Then
      begin
        pMensagemOk('Localização física ou lote deve ser informada.');
        pSetFocus(edtLocFis);
        blnMudarFoco := False;
        Result := false;
      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmSolicitacaodeReposicaodeGondola.fValidaQuantidade(AQtdIte: Double; ASalDis: Double): Boolean;
begin
  Result := False;
  If AQtdIte <= 0 Then
  begin
    pMensagemOk('A Quantidade deve ser maior que zero!');
    Exit;
  end;
  If AQtdIte > ASalDis Then
  begin
    pMensagemOk('A Quantidade não pode exceder o saldo disponível!');
    Exit;
  end;
  Result := True;
End;

function TfrmSolicitacaodeReposicaodeGondola.fCarregaItem(ACodIte: String; blnBuscaPorChave: Boolean): Boolean;
var strErro: String;
begin
  If blnBuscaPorChave Then
    pLimparCampos;
  Result := True;
  strErro := '';
  qryItem.SQL.Clear;
  qryItem.SQL.Add('SELECT CADITE.ITE_CODITE,');
  qryItem.SQL.Add('       CADITE.ITE_DESITE,');
  qryItem.SQL.Add('       CADITE.ITE_ITEATI,');
  qryItem.SQL.Add('       UNI_SIGUNI,');
  qryItem.SQL.Add('       MAR_DESMAR,');
  qryItem.SQL.Add('       CADITE.ITE_ITEATI,');
  qryItem.SQL.Add('       ITEGER.ITE_LOCFIS,');
  qryItem.SQL.Add('       (SELECT COUNT(1)');
  qryItem.SQL.Add('          FROM CADLOT');
  qryItem.SQL.Add('         WHERE LOT_CODEMP = "'+VS_strCodEmp+'"');
  qryItem.SQL.Add('           AND LOT_CODITE = CADITE.ITE_CODITE ) > 0 AS TEM_LOTE');
  qryItem.SQL.Add(' FROM CADITE ');
  qryItem.SQL.Add(' LEFT JOIN CADUNI ON UNI_CODUNI =  CADITE.ITE_CODUNI');
  qryItem.SQL.Add(' LEFT JOIN CADMAR ON MAR_CODMAR = CADITE.ITE_CODMAR');
  qryItem.SQL.Add(' LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = "'+ VS_strCodEmp + '"');
  qryItem.SQL.Add('WHERE TRUE');
  qryItem.SQL.Add('  AND CADITE.ITE_CODITE = "'+ACodIte+'"');
  qryItem.Open;

  If qryItem.IsEmpty Then
    strErro := 'Item não foi localizado!'
  Else If qryItem.FieldByName('ITE_ITEATI').AsString <> 'S' Then
    strErro := 'Item esta inativo!';

  If not fEmptyStr(strErro) Then
    Exit(False);

  edtCodIte.Text := ACodIte;
  edtDesIte.Text := qryItem.FieldByName('ITE_DESITE').AsString;
  edtMarca.Text := qryItem.FieldByName('MAR_DESMAR').AsString;;
  edtSigUni.Text := qryItem.FieldByName('UNI_SIGUNI').AsString;
  edtSaldos.Text := FormatFloat(mskSaldo, fRetSaldosEmpresa(ACodIte, VS_StrCodEmp, ''));
  edtSaldoDisponivel.Text := FormatFloat(mskSaldo, fRetornaSaldoDisponivel(ACodIte,
                                                                           False,
                                                                           False,
                                                                           '',
                                                                           True,
                                                                           VS_StrCodEmp,
                                                                           '',
                                                                           False,
                                                                           True,
                                                                           True,
                                                                           False,
                                                                           False,
                                                                           False,
                                                                           '',
                                                                           '',
                                                                           False,
                                                                           True));
  strLocFisOrigem := qryItem.FieldByName('ITE_LOCFIS').AsString;
  edtNumLot.Enabled := qryItem.FieldByName('TEM_LOTE').AsInteger > 0;
  pCarregaSolictacaoPendente(ACodIte, edtNumLot.Text, edtLocFis.Text);

end;

function TfrmSolicitacaodeReposicaodeGondola.fCarregaLote(ACodIte, ANumLot: String; blnBuscaPorChave: Boolean): Boolean;
var strErro: String;
    strLoteInvalido: String;
begin
  Result := True;
  If ANumLot = '' Then
    Exit;
  strErro := '';
  If ANumLot = 'A DEFINIR' Then
    strErro := 'O Lote não pode ser "A DEFINIR"!';
  If ANumLot = 'GARANTIA' Then
    strErro := 'O Lote não pode ser "GARANTIA"!';
  If fEmptyStr(strErro) Then
  Begin
    qryCadLot.SQL.Clear;
    qryCadLot.SQL.Add('SELECT * FROM CADLOT ');
    qryCadLot.SQL.Add(' WHERE LOT_CODITE = "'+ACodIte+'"');
    qryCadLot.SQL.Add('   AND LOT_CODEMP = "'+VS_StrCodEmp+'"');
    qryCadLot.SQL.Add('   AND LOT_NUMLOT = "'+ANumLot+'"');
    qryCadLot.Open;
    If qryCadLot.IsEmpty Then
      strErro := 'O Lote não foi encontrado!'
    Else
    Begin
      strLoteInvalido := '';
      If qryCadLot.FieldByName('LOT_TRANSI').AsString = 'S' Then
        strLoteInvalido := 'Transitório';
      If qryCadLot.FieldByName('LOT_PRIPRO').AsString = 'S' Then
        strLoteInvalido := 'de Ordem de Produção';
      If qryCadLot.FieldByName('LOT_GARPRI').AsString = 'S' Then
        strLoteInvalido := 'de Garantia';
      If Not strLoteInvalido.IsEmpty Then
        strErro := 'O Lote não não pode ser utiizado pois é um lote '+strLoteInvalido+' !';
    End;

  End;
  pLimparCamposLote;

  If Not fEmptyStr(strErro) Then
  Begin
    pMensagemOk(strErro);
    Exit(False)
  End;
  edtNumLot.Text := ANumLot;
  edtSaldoLote.Text := FormatFloat(mskSaldo, fRetSaldosEmpresa(ACodIte, VS_StrCodEmp, ANumLot));
  edtSaldoLoteDisponivel.Text := FormatFloat(mskSaldo, fRetornaSaldoDisponivel(ACodIte,
                                                                               False,
                                                                               False,
                                                                               ANumLot,
                                                                               True,
                                                                               VS_StrCodEmp,
                                                                               '',
                                                                               False,
                                                                               True,
                                                                               True,
                                                                               False,
                                                                               False,
                                                                               False,
                                                                               '',
                                                                               '',
                                                                               False,
                                                                               True));
  If blnBuscaPorChave And
     (Not fEmptyStr(qryCadLot.FieldByName('LOT_LOCFIS').AsString) And
     (qryCadLot.FieldByName('LOT_LOCFIS').AsString <> edtLocFis.Text)) Then
    edtLocFis.Text := qryCadLot.FieldByName('LOT_LOCFIS').AsString;
  If blnBuscaPorChave Then
    pCarregaSolictacaoPendente(ACodIte, ANumLot, edtLocFis.Text);


end;

function TfrmSolicitacaodeReposicaodeGondola.fGravarSolicitacao(pgbStatus: TcxProgressBar): Boolean;
var qrySQL: TUniQuery;
    DateHoraInicio: TDateTime;
begin
  Result := True;
  pgbStatus.Properties.Max := cdsSOLGON.RecordCount-1;
  DateHoraInicio := fNow;
  fStartTransaction;
  qrySQL := fCriaQuery;
  Try
    qrySQL.SQL.Add('INSERT INTO SOLGON (');
    qrySQL.SQL.Add('AUTOINCREM,');
    qrySQL.SQL.Add('SOL_CODEMP,');
    qrySQL.SQL.Add('SOL_CODOPE,');
    qrySQL.SQL.Add('SOL_CODITE,');
    qrySQL.SQL.Add('SOL_NUMLOT,');
    qrySQL.SQL.Add('SOL_QTDITE,');
    qrySQL.SQL.Add('SOL_OBSERV,');
    qrySQL.SQL.Add('SOL_LOCFIS,');
    qrySQL.SQL.Add('SOL_DTASOL,');
    qrySQL.SQL.Add('SOL_QTDATD,');
    qrySQL.SQL.Add('SOL_FISORI,');
    qrySQL.SQL.Add('SOL_STATUS');
    qrySQL.SQL.Add(')VALUES(');
    qrySQL.SQL.Add(':AUTOINCREM,');
    qrySQL.SQL.Add(':SOL_CODEMP,');
    qrySQL.SQL.Add(':SOL_CODOPE,');
    qrySQL.SQL.Add(':SOL_CODITE,');
    qrySQL.SQL.Add(':SOL_NUMLOT,');
    qrySQL.SQL.Add(':SOL_QTDITE,');
    qrySQL.SQL.Add(':SOL_OBSERV,');
    qrySQL.SQL.Add(':SOL_LOCFIS,');
    qrySQL.SQL.Add(':SOL_DTASOL,');
    qrySQL.SQL.Add(':SOL_QTDATD,');
    qrySQL.SQL.Add(':SOL_FISORI,');
    qrySQL.SQL.Add(':SOL_STATUS');
    qrySQL.SQL.Add(')');

    Try
      cdsSOLGON.First;
      while not cdsSOLGON.Eof Do
      begin
        qrySQL.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('SOLGON', VS_StrCodEmp);
        qrySQL.ParamByName('SOL_CODEMP').AsString := VS_StrCodEmp;
        qrySQL.ParamByName('SOL_CODOPE').Value := cdsSOLGON.FieldByName('SOL_CODOPE').Value;
        qrySQL.ParamByName('SOL_CODITE').Value := cdsSOLGON.FieldByName('SOL_CODITE').Value;
        qrySQL.ParamByName('SOL_NUMLOT').Value := cdsSOLGON.FieldByName('SOL_NUMLOT').Value;
        If fEmptyStr(qrySQL.ParamByName('SOL_NUMLOT').AsString) Then
          qrySQL.ParamByName('SOL_NUMLOT').Clear;
        qrySQL.ParamByName('SOL_QTDITE').Value := cdsSOLGON.FieldByName('SOL_QTDITE').Value;
        qrySQL.ParamByName('SOL_QTDATD').Value := cdsSOLGON.FieldByName('SOL_QTDITE').Value;
        qrySQL.ParamByName('SOL_OBSERV').Value := cdsSOLGON.FieldByName('SOL_OBSERV').Value;
        qrySQL.ParamByName('SOL_LOCFIS').Value := cdsSOLGON.FieldByName('SOL_LOCFIS').Value;
        qrySQL.ParamByName('SOL_STATUS').Value := cdsSOLGON.FieldByName('SOL_STATUS').Value;
        qrySQL.ParamByName('SOL_FISORI').Value := cdsSOLGON.FieldByName('SOL_FISORI').AsString;


        qrySQL.ParamByName('SOL_DTASOL').AsDateTime:= DateHoraInicio;
        qrySQL.ExecSQL;
        cdsSOLGON.Next;
        pgbStatus.Position := cdsSOLGON.RecNo;
      End;
      fCommit;
    Except
      on e: Exception do
      begin
        fRollBack;
        pMensagensErro(e.message, '[TfrmSolicitacaodeReposicaodeGondola.fGravarSolicitacao]');
        Result := false;
      End;
    End;
  Finally
    FreeAndNil(qrySQL);
  End;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.pCarregaItemCDS;
begin
  If cdsSOLGON.IsEmpty Then
    Exit;

  fCarregaItem(cdsSOLGON.FieldByName('SOL_CODITE').AsString, True);
  edtCodIte.Text := cdsSOLGON.FieldByName('SOL_CODITE').AsString;
  edtDesIte.Text := cdsSOLGON.FieldByName('ITE_DESITE').AsString;
  edtNumLot.Text := cdsSOLGON.FieldByName('SOL_NUMLOT').AsString;
  fCarregaLote(edtCodIte.Text, edtNumLot.Text, False);
  edtQtdIte.Text := cdsSOLGON.FieldByName('SOL_QTDITE').AsString;
  edtObservacao.Text := cdsSOLGON.FieldByName('SOL_OBSERV').AsString;
  edtLocFis.Text := cdsSOLGON.FieldByName('SOL_LOCFIS').AsString;

end;

procedure TfrmSolicitacaodeReposicaodeGondola.pCarregaSolictacaoPendente(ACodIte, ANumLot, ALocFis: String);
begin
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT SUM(SOL_QTDITE) AS QTD FROM SOLGON');
  qryConsulta.SQL.Add('  WHERE SOL_CODITE = "'+ACodIte+'"');
  qryConsulta.SQL.Add('    AND SOL_CODEMP = "'+VS_strCodEmp+'"');
  If Not fEmptyStr(ANumLot) Then
    qryConsulta.SQL.Add('    AND SOL_NUMLOT = "'+ANumLot+'"')
  Else If Not fEmptyStr(ALocFis) Then
    qryConsulta.SQL.Add('    AND SOL_LOCFIS = "'+ALocFis+'"');

  qryConsulta.SQL.Add('    AND SOL_STATUS = 0');
  qryConsulta.Open;
  lblSolicitacaoPendente.Visible := False;
  lblSolicitacaoPendente.Caption := '';
  If qryConsulta.FieldByName('QTD').AsFloat > 0 then
  begin
    lblSolicitacaoPendente.Visible := True;
    If fEmptyStr(ANumLot) then
      lblSolicitacaoPendente.Caption := 'Quantidade Solicitação Pendente para o Item/Localização Fisica: ' + FormatFloat(mskSaldo, qryConsulta.FieldByName('QTD').AsFloat)
    Else
      lblSolicitacaoPendente.Caption := 'Quantidade Solicitação Pendente para o Lote: ' + FormatFloat(mskSaldo, qryConsulta.FieldByName('QTD').AsFloat);
  End;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.pDeleteItem;
begin
  If cdsSOLGON.IsEmpty Then
    Exit;
  If fPergunta('Excluir o item: ' + cdsSOLGON.FieldByName('SOL_CODITE').AsString + ' - ' + cdsSOLGON.FieldByName('ITE_DESITE').AsString +'?') Then
    cdsSOLGON.Delete;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.pInsereRegistro;
begin
  cdsSOLGON.First;
  If cdsSOLGON.Locate('SOL_CODITE', edtCodIte.Text, []) Then
    cdsSOLGON.Edit
  Else
    cdsSOLGON.Insert;
  cdsSOLGON.FieldByName('SOL_CODEMP').AsString := VS_strCodEmp;
  cdsSOLGON.FieldByName('SOL_CODOPE').AsString := strCodOperador;
  cdsSOLGON.FieldByName('SOL_CODITE').AsString := edtCodIte.Text;
  cdsSOLGON.FieldByName('ITE_DESITE').AsString := edtDesIte.Text;
  cdsSOLGON.FieldByName('SOL_NUMLOT').AsString := edtNumLot.Text;
  cdsSOLGON.FieldByName('SOL_QTDITE').AsString :=  AnsiReplaceStr(edtQtdIte.Text, '.', '');
  cdsSOLGON.FieldByName('SOL_OBSERV').AsString := edtObservacao.Text;
  cdsSOLGON.FieldByName('SOL_LOCFIS').AsString := edtLocFis.Text;
  cdsSOLGON.FieldByName('SOL_FISORI').AsString := strLocFisOrigem;
  cdsSOLGON.FieldByName('SOL_STATUS').AsString := '0';
  cdsSOLGON.Post;
  pLimparCampos;
  pSetFocus(edtCodIte);
end;

procedure TfrmSolicitacaodeReposicaodeGondola.pLiberaProcesso;
begin
  pnlOperador.Enabled := False;
  pnlItens.Enabled := True;
  pnlGrid.Enabled := True;
end;

procedure TfrmSolicitacaodeReposicaodeGondola.pLimparCampos;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Clear;
  edtSaldoDisponivel.Clear;
  edtSaldos.Clear;
  edtMarca.Clear;
  edtSigUni.Clear;
  edtLocFis.Clear;
  edtObservacao.Clear;
  pLimparCamposLote;
  strLocFisOrigem := '';

end;

procedure TfrmSolicitacaodeReposicaodeGondola.pLimparCamposLote;
begin
  edtNumLot.Clear;
  edtSaldoLote.Clear;
  edtSaldoLoteDisponivel.Clear;
End;


procedure TfrmSolicitacaodeReposicaodeGondola.pReiniciaTela;
begin
  If Assigned(cdsSOLGON) Then
    FreeAndNil(cdsSOLGON);

  cdsSOLGON := TZClient.Create(Self, 'SELECT  SOLGON.*, CAST("" AS CHAR(100))ITE_DESITE FROM SOLGON WHERE FALSE');
  cdsSOLGON.fAbreClient(False, '[TfrmSolicitacaodeReposicaodeGondola.FormCreate]');
  dtsDados.DataSet := cdsSOLGON;
  strCodOperador := '';
  lblSolicitacaoPendente.Caption := '';
  btnConfirma.Enabled := False;
  pnlItens.Enabled := False;
  pnlOperador.Enabled := True;
  edtCodOpe.Clear;
  edtNomOpe.Clear;
  pSetFocus(edtCodOpe);
end;

end.




