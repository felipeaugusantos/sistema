unit untCadReceitAgronomico;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, EditFocus, untCadRctAgro, Uni, frxClass, frxDBSet,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, StrUtils, MemoFocus;

type
  TfrmCadReceitAgronomico = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlButtons: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    lblNumero: TLabel;
    lblCodVen: TLabel;
    lblCodPdc: TLabel;
    edtNumApl: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCultur: TEditFocus;
    lbl1: TLabel;
    edtArtigo: TEditFocus;
    pnlNovReg: TPanel;
    lblNovaOrdem: TLabel;
    lbl2: TLabel;
    edtDiagno: TEditFocus;
    lbl5: TLabel;
    edtNomCom: TEditFocus;
    lbl6: TLabel;
    edtGruQui: TEditFocus;
    lbl7: TLabel;
    edtClaTox: TEditFocus;
    lbl8: TLabel;
    edtAreRec: TEditFocus;
    lbl9: TLabel;
    edtPerCar: TEditFocus;
    lbl10: TLabel;
    edtManPra: TEditFocus;
    lbl11: TLabel;
    edtConcen: TEditFocus;
    lbl12: TLabel;
    edtFormul: TEditFocus;
    lbl13: TLabel;
    edtTotAdq: TEditFocus;
    lbl3: TLabel;
    edtDosApl: TEditFocus;
    lbl4: TLabel;
    edtIntApl: TEditFocus;
    lbl14: TLabel;
    edtModApl: TEditFocus;
    lbl15: TLabel;
    mmoEpoApl: TMemoFocus;
    btnPesquisar: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    Bevel1: TBevel;
    lblPriAti: TLabel;
    edtPriAti: TEditFocus;
    grpDadosAdd: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmoAlarme: TMemoFocus;
    mmoAntido: TMemoFocus;
    mmoObserv: TMemoFocus;
    btnTotAdq: TSpeedButton;
    Label4: TLabel;
    edtDosEsp: TEditFocus;
    btnReimprimir: TBitBtnLocked;
    btnExpCrea: TBitBtnLocked;
    btnExpFitoSan: TBitBtnLocked;
    FlwPnlButtons: TFlowPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCulturEnter(Sender: TObject);
    procedure edtCulturKeyPress(Sender: TObject; var Key: Char);
    procedure edtTotAdqExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnTotAdqClick(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
    procedure btnExpCreaClick(Sender: TObject);
    procedure btnExpFitoSanClick(Sender: TObject);
  private
    { Private declarations }
    strValidaRec: String;
    objCadGro: TCadGro;
    qryCadGro: TUniQuery;
    blnFecharForm: Boolean;

    blnNovo: Boolean;

    intSemaforoConfirma: Integer;

    strNomImp,
    strTipImp: String;

    blnReimpressao : Boolean;

    procedure pLimpaTela;
    procedure pImprimeReceita(strSeqRec, strNumArt: String);
    procedure pCarregaDadosCultura;
    procedure pCalcularTotalAdquirir;
    procedure pCalcularTotalAdquirirPadrao;
    procedure pCalcularTotalAdquirirPorQuantidadeReceituario;
    function fValor(edtValor: TEditFocus): Double;
    function fTiraLetras(strTexto: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
    procedure pHabilitaCampo(blnHabilita: Boolean);
  public
    strNumRec: String;
    strNumArt: String;
  end;

implementation

uses SysUtils, Graphics, untFuncoesSimples, untConsultas, untPai, untCadRctDadosMovGro,
  untCfgRel, untModuloRctAgro, untFuncoesGenerica, Data.DB, untTypesSistema,
  untFuncFatTypes, untCadReceitAgronomicoReimpressao,
  untCadReceitAgronomicoExpCrea, untCadReceitAgronomicoExpFitoSanitario;

{$R *.dfm}

function TfrmCadReceitAgronomico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCultur) Then
    Begin

      If Not fEmptyStr(edtCultur.Text) Then
      Begin
        objCadGro.strOperac := 'I';

        If objCadGro.fVerificaCadGroExiste(edtCodIte.Text, edtCultur.Text, edtArtigo.Text) Then
        Begin
          If (blnBuscaPorChave) Then
            pCarregaDadosCultura;

          edtCodIte.Enabled     := False;
          edtCultur.Enabled     := False;
          btnImprimir.Visible   := True;
          btnReimprimir.Visible := False;
          btnExpCrea.Visible    := False;
          btnExpFitoSan.Visible := False;

          objCadGro.strOperac := 'A';
          blnMudarFoco        := False;
        End
        Else
        Begin
          blnNovo               := False;
          lblNovaOrdem.Visible  := True;
          btnReimprimir.Visible := False;
          btnExpCrea.Visible    := False;
          btnExpFitoSan.Visible := False;
        End;

        pHabilitaCampo((Not fEmptyStr(edtDesIte.Text)) And (Not fEmptyStr(edtCultur.Text)));

        If (Not fEmptyStr(edtDesIte.Text)) And (Not fEmptyStr(edtCultur.Text)) Then
        Begin
          btnPesquisar.Enabled := False;
          edtArtigo.Text       := fCfgSis('ARTATU');
          blnNovo := True;

          //If (Not objCadGro.fVerificaLimiteARTAtual(edtArtigo.Text)) Then
          //Begin
          //  fMensagem('ATENÇÃO!!', 'Total de Receitas expedidas já excedeu' + #13#10 +
          //                         'o Total permitido da última A.R.T. concedida.', ['&O k']);
          //  pHabilitaCampo(False);
          //  Result := False;
          //End;
        End
        Else
        Begin
          If Not fValidaCampos(edtCodIte) Then
            blnMudarFoco := False;
        End;

        If Result Then
        Begin
          pnlInfo.Caption    := '';
          pnlInfo.Font.Color := clBlack;
        End;
      End
      Else
      Begin
        pHabilitaCampo(False);
        fMensagem('ATENÇÃO', 'Defina uma cultura!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodIte) Then
    Begin
      If Not fEmptyStr(edtCodIte.Text) Then
      Begin
        If Not fEhAgrotoxico(edtCodIte.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Este produto não é um item agrotóxico!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

          If fEmptyStr(edtDesIte.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Código do Produto não encontrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'Digite o código do produto!', ['&O k']);
        edtDesIte.Text := '';
        Result := False;
      End;
    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadReceitAgronomico.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodIte);
end;

procedure TfrmCadReceitAgronomico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objCadGro);
end;

procedure TfrmCadReceitAgronomico.FormCreate(Sender: TObject);
begin
  inherited;
  blnReimpressao      := False;
  blnNovo             := False;
  blnFecharForm       := False;
  intSemaforoConfirma := -1;

  objCadGro := TCadGro.Create(Self);
  qryCadGro := fCriaQuery(Self);

  With qryCadGro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT * FROM CADGRO WHERE FALSE ');
  End;

  pSetaCodIte(edtCodIte);

end;

procedure TfrmCadReceitAgronomico.pLimpaTela;
begin
  pnlBotoes.Enabled := True;

  objCadGro.strOperac := 'I';
  objCadGro.strCodIte := '';
  objCadGro.strDesIte := '';
  objCadGro.strCultur := '';
  objCadGro.strArtigo := '';
  objCadGro.strDiagno := '';
  objCadGro.strNomCom := '';
  objCadGro.strGruQui := '';
  objCadGro.strClaTox := '';
  objCadGro.strAreRec := '';
  objCadGro.strPerCar := '';
  objCadGro.strManPra := '';
  objCadGro.strConcen := '';
  objCadGro.strFormul := '';
  objCadGro.strTotAdq := '0';

  objCadGro.strDosApl := '';
  objCadGro.strDosEsp := '';
  objCadGro.strIntApl := '';
  objCadGro.strNumApl := '0';
  objCadGro.strModApl := '';
  objCadGro.strEpoApl := '';
  objCadGro.strPriAti := '';
  objCadGro.strAlarme := '';
  objCadGro.strAntido := '';
  objCadGro.strObserv := '';
  pnlInfo.Caption     := '';
  pnlInfo.Font.Color  := clBlack;

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCultur.Clear;
  edtArtigo.Clear;
  edtDiagno.Clear;
  edtNomCom.Clear;
  edtGruQui.Clear;
  edtClaTox.Clear;
  edtAreRec.Clear;
  edtPerCar.Clear;
  edtManPra.Clear;
  edtConcen.Clear;
  edtFormul.Clear;
  edtTotAdq.Text := '0';

  edtDosApl.Clear;
  edtDosEsp.Clear;
  edtIntApl.Clear;
  edtNumApl.Text := '0';
  edtModApl.Clear;
  mmoEpoApl.Clear;
  edtPriAti.Clear;
  mmoAlarme.Clear;
  mmoAntido.Clear;
  mmoObserv.Clear;

  btnConfirmar.Enabled  := True;
  btnImprimir.Visible   := False;
  btnReimprimir.Visible := True;
  btnExpCrea.Visible    := True;
  btnExpFitoSan.Visible := True;
  edtCodIte.Enabled     := True;
  edtCultur.Enabled     := True;

  strValidaRec := 'N';
  pSetFocus(edtCodIte);
  strValidaRec := 'S';

  lblNovaOrdem.Visible := False;
  pHabilitaCampo(False);
  blnMudarFoco := True;
end;

procedure TfrmCadReceitAgronomico.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaCampo(False);
  fInsereProCod('CADGRO');
  objCadGro.strOperac := 'I';
  strValidaRec        := 'S';

  If fEmptyStr(fCfgSis('ARTATU')) Then
  Begin
    fMensagem('', 'Antes de cadastrar uma nova receita,' + #13#10 + 'informe a A.R.T. nas configurações do sistema!', ['&O k']);
    blnFecharForm := True;
  End;

  edtTotAdq.Text := '0';
  edtNumApl.Text := '0';

  lblPriAti.Visible   := fCfgSis('IMPGRO', VarString) = '2';
  edtPriAti.Visible   := fCfgSis('IMPGRO', VarString) = '2';
  grpDadosAdd.Visible := fCfgSis('IMPGRO', VarString) = '2';
  edtPriAti.Text      := '';

  If Not grpDadosAdd.Visible Then
    Self.Height := Self.Height - grpDadosAdd.Height;
end;

procedure TfrmCadReceitAgronomico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10 : Begin
               Key := 0;
               If btnConfirmar.Enabled Then btnConfirmar.Click;
             End;
    VK_F7  : If btnImprimir.Visible   Then btnImprimir.Click;
    VK_F8  : If btnReimprimir.Visible Then btnReimprimir.Click;
    VK_F2  : If btnExpCrea.Visible    Then btnExpCrea.Click;
    VK_F3  : If btnExpFitoSan.Visible Then btnExpFitoSan.Click;

    VK_RETURN : If ((ActiveControl) = edtCultur) Then blnNovo := True;
  End;

  mmoEpoApl.OnKeyDown := pOnKeyDownEdits;
end;

procedure TfrmCadReceitAgronomico.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  Try

    If fVerificaCampos Then
    Begin

      objCadGro.strCodIte := edtCodIte.Text;
      objCadGro.strCultur := edtCultur.Text;
      objCadGro.strCodEmp := VS_strCodEmp;

      objCadGro.strDesIte := edtDesIte.Text;
      objCadGro.strArtigo := edtArtigo.Text;
      objCadGro.strDiagno := edtDiagno.Text;
      objCadGro.strNomCom := edtNomCom.Text;
      objCadGro.strGruQui := edtGruQui.Text;
      objCadGro.strClaTox := edtClaTox.Text;
      objCadGro.strAreRec := edtAreRec.Text;
      objCadGro.strPerCar := edtPerCar.Text;
      objCadGro.strManPra := edtManPra.Text;
      objCadGro.strConcen := edtConcen.Text;
      objCadGro.strFormul := edtFormul.Text;
      objCadGro.strTotAdq := edtTotAdq.Text;

      objCadGro.strDosApl := edtDosApl.Text;
      objCadGro.strDosEsp := edtDosEsp.Text;
      objCadGro.strIntApl := edtIntApl.Text;

      objCadGro.strNumApl := edtNumApl.Text;
      objCadGro.strModApl := edtModApl.Text;
      objCadGro.strEpoApl := mmoEpoApl.Text;
      objCadGro.strPriAti := edtPriAti.Text;
      objCadGro.strAlarme := mmoAlarme.Text;
      objCadGro.strAntido := mmoAntido.Text;
      objCadGro.strObserv := mmoObserv.Text;

      If (fMensagem('AVISO', 'Confirma gravação do Receituário Agronômico?', ['&Sim', '&Não']) = 1) Then
      Begin

        If objCadGro.fGravaCadGro Then
        Begin
          fMensagem('', 'Cadastro do Receituário Agronômico gravado com sucesso!', ['&O k']);
          strValidaRec := 'N';
        End;

        If fMensagem('', 'Deseja imprimir uma receita?', ['&Sim', '&Não']) = 1 Then
          btnImprimir.Click;

        pLimpaTela;

      End;

    End;

  Except
    On e:exception do
    Begin
      pMensagensErro(e.Message, 'btnConfirmarClick - untCadReceitAgronomico');
    End;
  End;

end;

procedure TfrmCadReceitAgronomico.pEscapePressed;
begin

  If ((ActiveControl) <> edtCodIte) Or
     ((ActiveControl) =  pnlBotoes) Or
     (ActiveControl.Parent = pnlButtons) Then
    pLimpaTela

  Else If ((ActiveControl) = edtCodIte) Then
    Inherited;

end;

procedure TfrmCadReceitAgronomico.pHabilitaCampo(blnHabilita: Boolean);
begin
  edtDiagno.Enabled := blnHabilita;
  edtNomCom.Enabled := blnHabilita;
  edtGruQui.Enabled := blnHabilita;
  edtClaTox.Enabled := blnHabilita;
  edtAreRec.Enabled := blnHabilita;
  edtPerCar.Enabled := blnHabilita;
  edtManPra.Enabled := blnHabilita;
  edtConcen.Enabled := blnHabilita;
  edtFormul.Enabled := blnHabilita;
  edtTotAdq.Enabled := blnHabilita;

  edtDosApl.Enabled := blnHabilita;
  edtDosEsp.Enabled := blnHabilita;
  edtIntApl.Enabled := blnHabilita;
  edtNumApl.Enabled := blnHabilita;
  edtModApl.Enabled := blnHabilita;
  mmoEpoApl.Enabled := blnHabilita;
  edtPriAti.Enabled := blnHabilita;
  mmoAlarme.Enabled := blnHabilita;
  mmoAntido.Enabled := blnHabilita;
  mmoObserv.Enabled := blnHabilita;
end;

procedure TfrmCadReceitAgronomico.btnExpCreaClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadReceitAgronomicoExpCrea, frmCadReceitAgronomicoExpCrea);
end;

procedure TfrmCadReceitAgronomico.btnExpFitoSanClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadReceitAgroExpFitoSanitario, frmCadReceitAgroExpFitoSanitario);
end;

procedure TfrmCadReceitAgronomico.btnImprimirClick(Sender: TObject);
  var
    frmCadRctDadosMovGro: TfrmCadRctDadosMovGro;
begin

  If (Not objCadGro.fVerificaLimiteARTAtual(edtArtigo.Text)) Then
  Begin
    fMensagem('ATENÇÃO!!', 'Total de Receitas expedidas já excedeu' + #13#10 +
                           'o Total permitido da última A.R.T. concedida.', ['&O k']);
    Exit;
  End;

  pCarregaConfImprRel(Self.Name, strNomImp, strTipImp);

  If (fCfgSis('IMPGRO', VarString) = '2') And
     (fEmptyStr(strNomImp)) Then
  Begin
    pMensagemOk('Defina uma fila para realizar a impressão da receita.');
    Exit;
  End;

  If (Not FileExists(ExtractFilePath(Application.ExeName) + '\RECEITA_SERVAGRO.fr3')) And
     (fCfgSis('IMPGRO', VarString) = '2')  Then
  Begin
    pMensagemOk('Não existe o arquivo de layout da receita agronômica na pasta do autcom. Favor solicitar para a Citel o arquivo "RECEITA_SERVAGRO.fr3".');
    Exit;
  End;

  If (InterlockedIncrement(intSemaforoConfirma) = 0) Then
  Begin

    Try
      inherited;

      If not blnReimpressao Then
      Begin

        pCriarFormularios(TfrmCadRctDadosMovGro, frmCadRctDadosMovGro);
        frmCadRctDadosMovGro.edtNroRec.Text := fStrZero(IntToStr(objCadGro.fProximoNroReceita(edtArtigo.Text)),6);
        frmCadRctDadosMovGro.mskDtaEmi.Text := DateToStr(VS_Date);

        If fCfgSis('IMPGRO', VarString) = '1' Then
          frmCadRctDadosMovGro.edtInfAdd.Text := 'LEIA ATENTAMENTO ABAIXO'
        Else
        Begin
          frmCadRctDadosMovGro.lbl3.Visible      := False;
          frmCadRctDadosMovGro.edtNroRec.Visible := False;
        End;

        With frmCadRctDadosMovGro Do
        If (ShowModal = mrOk) Then
        Begin
          If objCadGro.fGravaMovGro(strNumRec,
                                    edtNotFis.Text,
                                    mskDtaNot.Text,
                                    edtNroRec.Text,
                                    edtCodCli.Text,
                                    edtCodRes.Text,
                                    edtInfAdd.Text,
                                    mskDtaEmi.Text,
                                    objFazenda) Then
          Begin
            pImprimeReceita(strNumRec, edtArtigo.Text);
          End;
        End;
      End
      Else
        pImprimeReceita(strNumRec, strNumArt);

      InterlockedDecrement(intSemaforoConfirma);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoConfirma);
        pMensagensErro(E.Message, '');
      End;
    End;

    if Assigned(frmCadRctDadosMovGro) Then
      pFreeAndNil(frmCadRctDadosMovGro);

  End
  Else
    InterlockedDecrement(intSemaforoConfirma);

end;

procedure TfrmCadReceitAgronomico.btnPesquisarClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';

  If fPesqReceitAgro(Self, edtCodIte, edtCultur, edtArtigo, qryCadGro, chrKey, arrSel) Then
  Begin
    fValidaCampos(edtCodIte, True);
    fValidaCampos(edtCultur, True);
    pSetFocus(edtDiagno);
  End;

end;

procedure TfrmCadReceitAgronomico.btnReimprimirClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadReceitAgronomicoReimpressao, frmCadReceitAgronomicoReimpressao);
    blnReimpressao := True;
    frmCadReceitAgronomicoReimpressao.frmReimpressao := Self;
    frmCadReceitAgronomicoReimpressao.ShowModal;
  Finally
    blnReimpressao := False;
    FreeAndNil(frmCadReceitAgronomicoReimpressao);
  End;

end;

function TfrmCadReceitAgronomico.fValor(edtValor: TEditFocus): Double;
begin
  Result := fStrToFloat(fTiraLetras(edtValor.Text));
end;

function TfrmCadReceitAgronomico.fTiraLetras(strTexto: String): String;
Var
  caracter: Char;
begin
  Result := '';
  For caracter In strTexto Do
    If Not fEhLetra(caracter) Then
      Result := Result + caracter;
end;

procedure TfrmCadReceitAgronomico.btnTotAdqClick(Sender: TObject);
begin
  inherited;
  {************************************************************************}
  {* OS CAMPOS FORAM CRIADOS COMO VARCHAR E JA TEMOS CLIENTE USANDO,      *}
  {* NAO PODEMOS ALTERAR O TIPO DOS MESMOS. SE FAZ NECESSARIO VALIDAR SE  *}
  {* SAO NUMEROS ANTES DE REALIZAR O CALCULO DO TOTAL A ADQUIRIR          *}
  {********************************************************************JC**}

  If fValor(edtDosApl) = 0 Then
  Begin
    pMensagemOk('A dosagem da aplicação deve ser informada!');
    Exit;
  End;

  If fValor(edtDosEsp) = 0 Then
  Begin
    pMensagemOk('A dosagem especificada deve ser informada!');
    Exit;
  End;

  If fValor(edtAreRec) = 0 Then
  Begin
    pMensagemOk('A área de aplicação deve ser informada!');
    Exit;
  End;

  If fValor(edtNumApl) = 0 Then
  Begin
    pMensagemOk('O número de aplicações deve ser informado!');
    Exit;
  End;

  pCalcularTotalAdquirir;
end;

procedure TfrmCadReceitAgronomico.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  btnPesquisar.Enabled := True;
end;

procedure TfrmCadReceitAgronomico.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCons: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryCons := fCriaQuery(Nil);

    If fPesqItem(conIteSimples,
                 Self,
                 edtCodIte,
                 edtDesIte,
                 qryCons,
                 Key,
                 arrSel,
                 True,
                 nil,
                 'Consulta de Itens Agrotóxicos',
                 '1',
                 '',
                 0,
                 False,
                 False,
                 0,
                 cdrCodIte,
                 '',
                 False,
                 '',
                 '',
                 True,
                 False,
                 True,
                 '',
                 False,
                 False,
                 False,
                 False,
                 False,
                 True) then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryCons);

  End;

end;

procedure TfrmCadReceitAgronomico.edtCulturEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption      := '"/" para consulta de registro existente...';
  pnlInfo.Font.Color   := clBlue;
  lblNovaOrdem.Visible := False;
end;

procedure TfrmCadReceitAgronomico.edtCulturKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqCultura(Self, edtCultur, qryCadGro, Key, arrSel, edtCodIte.Text) Then
  Begin

    If objCadGro.fVerificaCadGroExiste(edtCodIte.Text,
                                       edtCultur.Text,
                                       qryCadGro.FieldByName('AGR_ARTIGO').AsString) Then
    Begin
      pCarregaDadosCultura;
    End;

    fValidaCampos(edtCultur, True);
    pSetFocus(edtDiagno);  
  End;

end;

procedure TfrmCadReceitAgronomico.edtTotAdqExit(Sender: TObject);
begin
  inherited;
  edtTotAdq.Text := FloatToStrF(fStrToFloat(edtTotAdq.Text),ffNumber,12,3);
end;

procedure TfrmCadReceitAgronomico.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmCadReceitAgronomico.pImprimeReceita(strSeqRec, strNumArt: String);
  Var
    qryRelPro  : TUniQuery;
    qckRel     : TfrxReport;
    qryCadEmp  : TUniQuery;
begin

  Try
    qryRelPro := fCriaQuery;

    qryCadEmp := fCriarQuery('SELECT * FROM CADEMP WHERE EMP_CODEMP = ' + QuotedStr(VS_strCodEmp));
    If Not qryCadEmp.Active Then qryCadEmp.Open;

    With qryRelPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  MOVGRO.*, ');
      SQL.Add('  CONCAT(MGR_CODCLI, "-", MGR_NOMCLI) AS CLINOM, ');
      SQL.Add('  CONCAT(MGR_CIDCLI, "-", MGR_ESTCLI) AS CLICID, ');
      SQL.Add('  CONCAT(MGR_CODRES, "-", MGR_NOMRES) AS CLIRES  ');
      SQL.Add('FROM ');
      SQL.Add('  MOVGRO ');
      SQL.Add('WHERE ');
      SQL.Add('  MGR_NUMREC = :NUMREC AND ');
      SQL.Add('  MGR_ARTIGO = :NUMART     ');
      ParamByName('NUMREC').AsString := strSeqRec;
      ParamByName('NUMART').AsString := strNumArt;
      Open;
    End;

    If Not qryRelPro.IsEmpty Then
    Begin

      Try
        pCriarFormularios(TfrmModuloRctAgro, frmModuloRctAgro);
        With frmModuloRctAgro Do
        Begin

          frxRelatorio.DataSet := qryRelPro;

          If fCfgSis('IMPGRO', VarString) = '1' Then
          Begin
            strTipImp := 'J';

            // Impressão Laboraves sempre será jato de tinta
            qckRel := frxReportJ;

            qckRel.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

            qckRel.Script.Variables['END001'] := qryCadEmp.FieldByName('EMP_ENDERE').AsString + ', '  +
                                                 qryCadEmp.FieldByName('EMP_ENDNUM').AsString;
            qckRel.Script.Variables['END002'] := qryCadEmp.FieldByName('EMP_BAIRRO').AsString + ' - ' +
                                                 fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 0) + '-' +
                                                 fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
            qckRel.Script.Variables['END003'] := 'E-mail: '    + qryCadEmp.FieldByName('EMP_EMAIL_').AsString + ' - ' +
                                                 'Home Page: ' + qryCadEmp.FieldByName('EMP_HOMEPA').AsString;
            qckRel.Script.Variables['END004'] := 'Fone/Fax: '  + fFormataFone(qryCadEmp.FieldByName('EMP_FONE01').AsString) +
                                                 ' - CEP: '    + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

            pPreviewReport(Self.Name, Self.Caption, qckRel);
          End
          Else
          Begin
            strTipImp := 'M';

            frxServAgro.LoadFromFile(ExtractFilePath(Application.ExeName) + '\RECEITA_SERVAGRO.fr3');
            frxServAgro.PrintOptions.Printer    := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
            frxServAgro.PrintOptions.PrintMode := pmSplit;
            frxServAgro.PrintOptions.ShowDialog := False;

            // Impressão Serv Agro sempre será matricial
            If frxServAgro.PrepareReport Then
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxServAgro);
          End;
        End;

        If fCfgSis('IMPGRO', VarString) = '1' Then
          pMensagemOk('Receita Agronômica nro. ' + qryRelPro.FieldByName('MGR_NROREC').AsString + ' impressa com sucesso!!!')
        Else
          pMensagemOk('Receita Agronômica nro. ' + qryRelPro.FieldByName('MGR_NUMREC').AsString + ' impressa com sucesso!!!')
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
        End;
      End;
      FreeAndNil(qckRel);
      FreeAndNil(qryRelPro);
      FreeAndNil(frmModuloRctAgro);
    End
    Else
      pMensagemOk('Receita Agronômica não encontrada para impressão!');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeReceita]');
    End;
  End;

end;

procedure TfrmCadReceitAgronomico.pCalcularTotalAdquirir;
var
  strTipCalc: String;
begin
  strTipCalc := fCfgSis('CLCCTR', VarString);
  If (strTipCalc = '2') Then
  Begin
    pCalcularTotalAdquirirPorQuantidadeReceituario;
  End
  Else
    pCalcularTotalAdquirirPadrao

end;

procedure TfrmCadReceitAgronomico.pCalcularTotalAdquirirPadrao;
begin
  {******************************************************************************}
  {*                                                                            *}
  {*   - APLICAR A SEGUINTE REGRA PARA O CAMPO ( TOTAL A ADQUIRIR ):            *}
  {*    ---------------------------------------------------------------------   *}
  {*     nTOTADQ := nDOSQTD * ( nAREAPL / nDOSESP ) * nNUMAPL                   *}
  {*    ---------------------------------------------------------------------   *}
  {*   - ONDE:                                                                  *}
  {*     * nDOSQTD --> DOSAGEM APLICACAO                                        *}
  {*     * nAREAPL --> AREA APLICACAO                                           *}
  {*     * nDOSESP --> DOSAGEM ESPECIFICADA                                     *}
  {*     * nNUMAPL --> NUMERO DE APLICACAO                                      *}
  {*                                                                            *}
  {** REQUISITO: 37111 ****************************************************RO,JC*}
  edtTotAdq.Text := FormatFloat('#,##.000', fValor(edtDosApl) *
    (fValor(edtAreRec) / fValor(edtDosEsp)) * fValor(edtNumApl));
end;

procedure TfrmCadReceitAgronomico.pCalcularTotalAdquirirPorQuantidadeReceituario;
var
  fltTotAdq: Double;
  fltVlrArt: Double;
  fltQtdRec: Double;
begin
  fltVlrArt := fCfgSis('VLRART', varDouble);
  fltQtdRec := fCfgSis('QTDREC', varDouble);

  If fltQtdRec <= 0 Then
  Begin
    pMensagemOk('A configuração [CFG_QTDREC] precisa ser informada para calcular por quantidade de receituário!');
    Exit;
  End;

  {* Fórmula para calcular por ART: [ (VALOR POR ART) / (QUANTIDADE DE RECEITUÁRIOS POR ART) ]  *}
  fltTotAdq := fltVlrArt / fltQtdRec;
  edtTotAdq.Text := FormatFloat('#,##.000', fltTotAdq);
end;

procedure TfrmCadReceitAgronomico.pCarregaDadosCultura;
begin
  objCadGro.strArtigo := fCfgSis('ARTATU');
  objCadGro.strArtigo := objCadGro.strArtigo;

  edtArtigo.Text := objCadGro.strArtigo;
  edtDiagno.Text := objCadGro.strDiagno;
  edtNomCom.Text := objCadGro.strNomCom;
  edtGruQui.Text := objCadGro.strGruQui;
  edtClaTox.Text := objCadGro.strClaTox;
  edtAreRec.Text := objCadGro.strAreRec;
  edtPerCar.Text := objCadGro.strPerCar;
  edtManPra.Text := objCadGro.strManPra;
  edtConcen.Text := objCadGro.strConcen;
  edtFormul.Text := objCadGro.strFormul;
  edtTotAdq.Text := objCadGro.strTotAdq;

  edtDosApl.Text := objCadGro.strDosApl;
  edtDosEsp.Text := objCadGro.strDosEsp;
  edtIntApl.Text := objCadGro.strIntApl;
  edtNumApl.Text := objCadGro.strNumApl;
  edtModApl.Text := objCadGro.strModApl;
  mmoEpoApl.Text := objCadGro.strEpoApl;
  edtPriAti.Text := objCadGro.strPriAti;
  mmoAlarme.Text := objCadGro.strAlarme;
  mmoAntido.Text := objCadGro.strAntido;
  mmoObserv.Text := objCadGro.strObserv;
end;

End.
