{***************************}
{* qryConEmp -> CADEMP     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untDesmembrValores;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, Mask, MaskEditFocus, Menus, Uni, DB,
  AppEvnts, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Math, untFrameCentroCustoEditFocus,
  untFramePlanoDeContasMaskEdit,untTValidaCorrespondenteContabil, untTypesSistema,
  StrUtils;

type
  TfrmDesmembrValores = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    lblTipo: TLabel;
    edtValor: TEditFocus;
    pnlInformativo: TPanel;
    Label3: TLabel;
    edtNomEmp: TEditFocus;
    edtPercDup: TEditFocus;
    edtPercGeral: TEditFocus;
    Label5: TLabel;
    edtPercDiferenca: TEditFocus;
    Label6: TLabel;
    pnlTipo: TPanel;
    rdbValor: TRadioButton;
    rdbPorcen: TRadioButton;
    Label4: TLabel;
    chkEventos: TCheckBox;
    dbgValores: TDBGridCitel;
    lbl1: TLabel;
    edtNumDup: TEditFocus;
    edtParcel: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnAlteraCC: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    Label7: TLabel;
    Label8: TLabel;
    edtTotGeral: TEditFocus;
    edtTotDup: TEditFocus;
    edtDiferenca: TEditFocus;
    Label9: TLabel;
    btnCancela: TBitBtnLocked;
    btnClose: TBitBtnLocked;
    btnInserir: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    btnMarcarTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgValoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbgValoresDblClick(Sender: TObject);
    procedure chkEventosClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure dbgValoresDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnAlteraCCClick(Sender: TObject);
    procedure rdbValorClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
  private
    { Private declarations }
    qryConEmp: TUniQuery;
    qryConCta: TUniQuery;
    FEmpresasSelecionadas: TConsultasArray;

    FDatasetCtpDet: TUniClientDataSet;

    procedure pTestaMarcados;
    procedure pMarcaDesmarcaCtpDet;
    procedure pMarcaItemAlteracao;
    procedure pDesmarcaTodos;
    procedure pMarcarTodos;
    procedure pEscolheCentroCustoParaMarcar;
    procedure pAlteraCentroCusto;
    procedure pUpdateCentroCusto(strCodConta: String);

    procedure pLimpaEdits;

    procedure pCriaTemporariaCtpDet;
    procedure pAdicionaRegistro;
    procedure pAlteraRegistro;

    procedure pDeletaRegistro;
    procedure pCalculaValDup;
    procedure pCalculaFatCal;

    procedure pCarregaEmpresa;
    procedure pCarregaCentroCusto;
    procedure pCarregaEventos;

    procedure pAtribuiTabelas;

    function fCalculaTotal: Double;
    function fValidaValores(strCodConta: String = ''): Boolean;
    function fVerificaItensEventos : Boolean;
    function DivergenciaDeValores:Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    dtsCtpDet: TDataSource;
    cdsCtpDetBkp: TUniClientDataSet;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    blnAltera: Boolean;
    blnInsere: Boolean;
    blnGrid  : Boolean;
    blnGerAut: Boolean;

    strNumDup: String;
    strParcel: String;
    strSerie : String;
    strCodEmp: String;
    strCodFor: String;
    AAtualiza: Boolean;

    strDuplGerAut: String;
    strParcGerAut: String;

    fltValTot: Double;

    blnBaixada: Boolean;
    blnEntMer: Boolean;
    strCtaMar: String;
    strCodCta: String;
    strCodEve: String;
    FPlanoContasSelecionadoParaMarcarTodos: String;
    fltSomaPercentual: Double;
    fltValorAnterior: Double;
    fltPercentualAnt: Double;
    blnEntMerAut: Boolean;
    procedure pDeletaTemporariaCtpDet;
    procedure pMostraEventos(blnMostra : Boolean);

    procedure pAtualizaTemporariaCtpDet;
    procedure DesabilitaTodosBotoes;

    property DatasetCtpDet: TUniClientDataset read FDatasetCtpDet write FDatasetCtpDet;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untDigCentroCusto, untCadCta, untCadPag,
  untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmDesmembrValores.pAtualizaTemporariaCtpDet;
  Var
    SprcScroll: TprcScroll;

    LFiltroAnterior: String;
begin

  If (Not Assigned(FDatasetCtpDet)) Or (Not FDatasetCtpDet.Active)  Then
    pCriaTemporariaCtpDet;

  pDisableControls(FDatasetCtpDet, SprcScroll);

  LFiltroAnterior := FDatasetCtpDet.Filter;

  FDatasetCtpDet.Filter := 'TIPOACAO <> ''3'' ';
  FDatasetCtpDet.Filtered := True;
  Try
    If Not fEmptyStr(strDuplGerAut) And Not fEmptyStr(strParcGerAut) Then
    Begin
      FDatasetCtpDet.Filtered := False;
      FDatasetCtpDet.Filter   := ' CTP_NUMDUP = ' + QuotedStr(strDuplGerAut) + ' AND ' +
                                 ' CTP_PARCEL = ' + QuotedStr(strParcGerAut) + ' AND ' +
                                 ' TIPOACAO <> ''3'' ';
      FDatasetCtpDet.Filtered := True;
    End;

    FDatasetCtpDet.IndexFieldNames := 'CTP_CODEMP;CTP_CODCTA;CTP_CODEVE';
    (FDatasetCtpDet.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (FDatasetCtpDet.FieldByName('PERCENTUAL') AS TFloatField).DisplayFormat := '#,##0.00';
    FDatasetCtpDet.FieldByName('CTP_CODCTA').EditMask := '99.99.999;0;_';

    If Not FDatasetCtpDet.IsEmpty Then
      pnlTipo.Enabled := False
    Else If blnGerAut Then
      pnlTipo.Enabled := False
    Else
    Begin
      pnlTipo.Enabled := True;
      If (Not chkEventos.Checked) Then
      Begin
        pMostraEventos(False);
        chkEventos.Checked := False;
      End;
    End;

    If fVerificaItensEventos Then
    Begin
      pMostraEventos(True);
      chkEventos.Checked := True;
    End
    Else If (Not chkEventos.Checked) Then
    Begin
      pMostraEventos(False);
      chkEventos.Checked := False;
    End;

    edtTotDup.Text        := FloatToStrF(fCalculaTotal, ffNumber, 14, 2);
    edtDiferenca.Text     := FormatFloat('#,##0.00', fStrToFloat(edtTotGeral.Text) - fStrToFloat(edtTotDup.Text));
    edtPercDup.Text       := FloatToStrF(fltSomaPercentual, ffNumber, 14, 2);
    edtPercDiferenca.Text := FormatFloat('#,##0.00', fStrToFloat(edtPercGeral.Text) - fStrToFloat(edtPercDup.Text));

    dbgValores.Repaint;
  Finally
    FDatasetCtpDet.Filter := LFiltroAnterior;
    If LFiltroAnterior.IsEmpty Then
      FDatasetCtpDet.Filter := 'TIPOACAO <> ''3'' ';
    FDatasetCtpDet.Filtered := True;

    If dtsCtpDet = Nil Then
    Begin
      dtsCtpDet := TDataSource.Create(Self);
      dbgValores.DataSource := dtsCtpDet;
    End;

    dtsCtpDet.DataSet := FDatasetCtpDet;

    pEnableControls(FDatasetCtpDet, SprcScroll);
    FDatasetCtpDet.First;
  End;
end;

procedure TfrmDesmembrValores.pCriaTemporariaCtpDet;
begin

  untCadPag.pCriaClientTemporariaCtpDet(strNumDup,
                                        strParcel,
                                        strSerie,
                                        strCodEmp,
                                        strCodFor,
                                        FDatasetCtpDet);

end;

procedure TfrmDesmembrValores.pDeletaTemporariaCtpDet;
begin
  pDeletaTemporariaCtpDet;
end;

procedure TfrmDesmembrValores.FormCreate(Sender: TObject);
var
  blnCTPOBE: Boolean;
begin
  inherited;
  fltValTot := 0.0;
  blnEntMer := False;

  strDuplGerAut := '';
  strParcGerAut := '';
  blnGerAut     := False;

  strCodCta     := '';
  strCodEve     := '';
  FPlanoContasSelecionadoParaMarcarTodos    := '';

  blnCTPOBE := fCfgSis('CTPOBE', varBoolean);
  chkEventos.Checked := blnCTPOBE;
  chkEventos.Enabled := Not blnCTPOBE;
  blnEntMerAut := False;
end;

procedure TfrmDesmembrValores.fraCentroCustoedtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if blnEntMerAut then
    Exit;

  fraCentroCusto.edtCodEveKeyPress(Sender, Key);
end;

procedure TfrmDesmembrValores.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  if blnEntMerAut then
    Exit;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Or
         fEmptyStr(strCodFor) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, strCodFor) Then
      Begin
          If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
            Self.SelectNext(ActiveControl, True, True);

      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, strCodFor) Then
      Begin
          If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
            Self.SelectNext(ActiveControl, True, True);

      End;
    End;

    pCarregaCentroCusto;
  End;

end;

function TfrmDesmembrValores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓD. DA EMPRESA              *}
    {**************************************MV*}
    If (Sender = edtCodEmp) And edtCodEmp.Enabled Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If edtCodEmp.Text <> '000' Then
        begin
          SetLength(FEmpresasSelecionadas, 0);
          pCarregaEmpresa;
          SetLength(FEmpresasSelecionadas,1);
          FEmpresasSelecionadas[0].strCodigo := edtCodEmp.Text;

          if qryConEmp.FieldByName('EMP_EMPATI').AsString = 'N' Then
          begin
            fMensagem('ATENÇÃO!', 'Esta empresa está inativa no Cadastro de Empresas.' + #13#10 +
                      'Não é possível utilizá-la nesta rotina.', ['&O k']);
            Result := False;
          end;
        end;

        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If Assigned(FValidaCorrespondenteContabil) And (edtCodEmp.Text <> '000') And
            Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.MskCodCta.Text,edtCodEmp.Text) Then
        Begin
          pSetFocus(fraPlanoDeContas.MskCodCta);
          Exit(False);
        End
        Else If (fraCentroCusto.Visible = False) Then
        Begin
          If blnBuscaPorChave then
          Begin
            If Not fValidaValores Then
            Begin
              If blnGrid Then
              Begin
                blnAltera := True;
                blnInsere := False;
                blnGrid := False;
                pAtualizaTemporariaCtpDet;
              End
              Else
              Begin
                If (fMensagem('', 'Já existe uma Conta com esses dados! Deseja alterá-la?', ['&Sim', '&Não']) = 1) Then
                Begin
                  blnAltera := True;
                  blnInsere := False;
                End
                Else
                Begin
                  pSetFocus(fraPlanoDeContas.MskCodCta);
                  pAtualizaTemporariaCtpDet;
                  blnMudarFoco := False;
                  Exit;
                End;
              End;
            End
            Else
            Begin
              pAtualizaTemporariaCtpDet;
              blnInsere := True;
              blnaltera := False;
            End;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) And (fraCentroCusto.Visible) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEventos;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End
        Else If fVerificaEventoCfgContabil(fraCentroCusto.edtCodEve.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse centro de custo não pode ser aplicado no desmembramento, ' +#13+#10+
                               'pois está configurado na lista de eventos que não serão exportados para a contabilidade!',['&OK']);
          Result := False;
        End
        Else If blnBuscaPorChave then
        Begin
          If (Not fValidaValores) Then
          Begin
            If blnGrid Then
            Begin
              blnAltera := True;
              blnInsere := False;
              blnGrid := False;
              pAtualizaTemporariaCtpDet;
            End
            Else
            Begin
              If (fMensagem('', 'Já existe uma Conta com esses dados! Deseja alterá-la?', ['&Sim', '&Não']) = 1) Then
              Begin
                blnAltera := True;
                blnInsere := False;
              End
              Else
              Begin
                pSetFocus(fraPlanoDeContas.MskCodCta);
                pAtualizaTemporariaCtpDet;
                blnMudarFoco := False;
                Exit;
              End;
            End;

            If blnAltera Then
            Begin
              pAlteraRegistro;
              pAtualizaTemporariaCtpDet;
            End;
          End
          Else
          Begin
            pAtualizaTemporariaCtpDet;
            blnInsere := True;
            blnaltera := False;

            {If fVerificaCampos And blnInsere And Not blnAltera Then
            Begin
              pAdicionaRegistro;
              pSetFocus(mskCodCta);
              pLimpaEdits;
              blnMudarFoco := False;
              blnAltera := False;
              blnInsere := True;
            End}
          End;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Digite o código do Centro de Custos !', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) And ( fEmptyStr(edtValor.Text) Or (edtValor.Text = '0,00')) Then
      Begin
        pSetFocus(dbgValores);
        fraPlanoDeContas.edtDesCta.Clear;
        blnMudarFoco := False;
      End
      Else If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) And (Not fEmptyStr(edtValor.Text) Or (edtValor.Text <> '0,00')) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End
      Else If Assigned(FValidaCorrespondenteContabil) And (edtCodEmp.Text <> '000') And
          Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.MskCodCta.Text,edtCodEmp.Text) Then
      Begin
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto;

        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not fCfgSis('USACTF', varBoolean) Or
                 fEmptyStr(strCodFor) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DIGITADO               *}
    {**************************************MV*}
    Else If (Sender = edtValor) And (blnInsere or blnAltera) Then
    Begin
      If fEmptyStr(edtValor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtValor.Text) = 0) Then
      Begin
        fMensagem('', 'O Valor deve ser diferente de zero!', ['&O k']);
        Result := False;
      End
      Else If (rdbPorcen.Checked) And ((fStrToFloat(edtValor.Text) > 100) Or (fStrToFloat(edtValor.Text) < 0)) Then
      Begin
        fMensagem('', 'O Valor do percentual deve ser entre 0 e 100!', ['&O k']);
        Result := False;
      End                                        {
      Else If (rdbValor.Checked) And (fStrToFloat(edtTotGeral.Text) > 0) And (fStrToFloat(edtValor.Text) < 0) Then
      Begin
        fMensagem('', 'O Valor deve ser Positivo!', ['&O k']);
        Result := False;
      End
      Else If (rdbValor.Checked) And  (fStrToFloat(edtTotGeral.Text) < 0) And (fStrToFloat(edtValor.Text) > 0) Then
      Begin
        fMensagem('', 'O Valor deve ser Negativo!', ['&O k']);
        Result := False;
      End                                       }
      Else If (Not fValidaValores) And blnBuscaPorChave And blnAltera Then
      Begin

        If FDatasetCtpDet.fieldbyname('CTP_DEBCRE').AsString.Equals('D') Then
        Begin
          rdbPorcen.Enabled := True;
        End;

        pAlteraRegistro;
        pAtualizaTemporariaCtpDet;
      End;
      {Else If blnBuscaPorChave And fVerificaCampos And blnInsere And Not blnAltera Then
      Begin
        pAdicionaRegistro;
        pSetFocus(mskCodCta);
        pLimpaEdits;
        blnMudarFoco := False;
        blnAltera := False;
        blnInsere := True;
      End;}

    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmDesmembrValores.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmDesmembrValores.pCarregaCentroCusto;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    If fEmptyStr(edtCodEmp.Text) Then
      pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor)
    Else
      pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor);

  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

{*****************************************}
{* ADICIONA UM REGISTRO NA TEMPORARIA    *}
{**************************************MV*}
procedure TfrmDesmembrValores.pAdicionaRegistro;
var
  fltPercen, fltValDup: Double;
  LValorPorEmpresa : Double;
  LContador : Integer;
begin
  If Not fValidaValores Then
  Begin
    blnAltera := True;
    blnInsere := False;

    If fMensagem('', 'Já existe uma Conta com esses dados! Deseja alterá-la?',['&Sim','&Não']) = 1 Then
    Begin
      pAlteraRegistro;
      pAtualizaTemporariaCtpDet;
    End;

    pLimpaEdits;
    Exit;
  End;

  If Not FDatasetCtpDet.Active Then
    FDatasetCtpDet.Open;

  LValorPorEmpresa := fStrToFloat(edtValor.Text) / (High(FEmpresasSelecionadas) + 1);

  For LContador := 0 to High(FEmpresasSelecionadas) Do
  Begin
    FDatasetCtpDet.Insert;
    FDatasetCtpDet.FieldByName('CTP_MARDES').AsString := 'D';
    FDatasetCtpDet.FieldByName('CTP_NUMDUP').AsString := edtNumDup.Text;
    FDatasetCtpDet.FieldByName('CTP_PARCEL').AsString := edtParcel.Text;
    FDatasetCtpDet.FieldByName('CTP_CODEMP').AsString := FEmpresasSelecionadas[LContador].strCodigo;
    FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;
    FDatasetCtpDet.FieldByName('CTA_DESCTA').AsString := fraPlanoDeContas.edtDesCta.Text;
    FDatasetCtpDet.FieldByName('CTP_CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
    FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat  := 0;
    FDatasetCtpDet.FieldByName('TIPOACAO').AsString   := '1';

    If rdbPorcen.Checked Then
    Begin
      FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat  := fFormataFloat(fltValTot * (LValorPorEmpresa / 100), 2);
      FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat  := LValorPorEmpresa;

      {******************************************************************************
       *  Se houver divergência entre o valor total do desmembramento calculado     *
       *  e o valor da duplicata, recalculo o valor do último desmembramento,       *
       *  obrigando o mesmo a respeitar o valor máximo da duplicata.                *
       ****************************************************************KP*REQ.83093**}

      fltPercen := (fStrToFloat(edtPercDup.Text)+FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat);
      If  fltPercen = 100 Then
      Begin
        fltValDup := (fStrToFloat(edtTotDup.Text)+FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat);
        If fltValDup <> fltValTot Then
          FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat := fltValTot - fStrToFloat(edtTotDup.Text);
      End;
    End
    Else
    Begin
      FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat  := LValorPorEmpresa;
      FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat  := ((LValorPorEmpresa / fltValTot) * 100);
    End;

    FDatasetCtpDet.Post;
  End;

  pAtualizaTemporariaCtpDet;

  FDatasetCtpDet.Last;

  pAtualizaTemporariaCtpDet;

  FDatasetCtpDet.Last;

end;

{*****************************************}
{* ALTERA UM REGISTRO NA TEMPORARIA      *}
{**************************************LU*}
procedure TfrmDesmembrValores.pAlteraRegistro;
VAR
  fltValorParaCalculo, fltPercen, fltValDup, fltValDupAnt: Double;
begin
  If rdbPorcen.Checked Then
  begin
    fltValorParaCalculo := (fStrToFloat(edtPercDup.Text) - fltPercentualAnt);
    fltValorParaCalculo := fFormataFloat(fltValorParaCalculo, 2);
  end
  else
    fltValorParaCalculo := (fStrToFloat(edtTotDup.Text) - fltValoranterior);

  If Not fEmptyStr(strDuplGerAut) And Not fEmptyStr(strParcGerAut) Then
  Begin
    If FDatasetCtpDet.Locate('CTP_CODCTA;CTP_CODEMP;CTP_CODEVE;CTP_NUMDUP;CTP_PARCEL', VarArrayOf([fraPlanoDeContas.MskCodCta.Text,edtCodEmp.Text,fraCentroCusto.edtCodEve.Text,strDuplGerAut,strParcGerAut]), []) Then
    Begin
      FDatasetCtpDet.Edit;

      If rdbPorcen.Checked Then
      begin
        fltValDupAnt := FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat;
        FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat  := fFormataFloat(fltValTot * (fStrToFloat(edtValor.Text) / 100), 2);
        FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat  := fStrToFloat(edtValor.Text);

      {******************************************************************************
       *  Se houver divergência entre o valor total do desmembramento calculado     *
       *  e o valor da duplicata, recalculo o valor do último desmembramento,       *
       *  obrigando o mesmo a respeitar o valor máximo da duplicata.                *
       ****************************************************************KP*REQ.83093**}

        fltPercen := (fltValorParaCalculo+FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat);
        if  fltPercen = 100 then
        begin
          fltValDup := (fStrToFloat(edtTotDup.Text)-fltValDupAnt)+FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat;
          if fltValDup <> fltValTot then
            FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat := fltValTot - (fStrToFloat(edtTotDup.Text)-fltValDupAnt);
        end;

      end
      else
      begin
        FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat  := fStrToFloat(edtValor.Text);
        FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat  := ((fStrToFloat(edtValor.Text) / fltValTot) * 100);
      end;

      If Not FDatasetCtpDet.FieldByname('INCREMENTO').AsString.IsEmpty Then
        FDatasetCtpDet.FieldByName('TIPOACAO').AsString := '2';

      FDatasetCtpDet.Post;
    End;
  End
  Else
  Begin
    If FDatasetCtpDet.Locate('CTP_CODCTA;CTP_CODEMP;CTP_CODEVE', VarArrayOf([fraPlanoDeContas.MskCodCta.Text,edtCodEmp.Text,fraCentroCusto.edtCodEve.Text]), []) Then
    Begin
      FDatasetCtpDet.Edit;

      If rdbPorcen.Checked Then
      begin
        fltValDupAnt := FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat;
        FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat  := fFormataFloat(fltValTot * (fStrToFloat(edtValor.Text) / 100), 2);
        FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat  := fStrToFloat(edtValor.Text);

       {******************************************************************************
        *  Se houver divergência entre o valor total do desmembramento calculado     *
        *  e o valor da duplicata, recalculo o valor do último desmembramento,       *
        *  obrigando o mesmo a respeitar o valor máximo da duplicata.                *
        ****************************************************************KP*REQ.83093**}

        fltPercen := (fltValorParaCalculo+FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat);
        if  fltPercen = 100 then
        begin
          fltValDup := (fStrToFloat(edtTotDup.Text)-fltValDupAnt)+FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat;
          if fltValDup <> fltValTot then
            FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat := fltValTot - (fStrToFloat(edtTotDup.Text)-fltValDupAnt);
        end;

      end
      else
      begin
        FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat  := fStrToFloat(edtValor.Text);
        FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat  := ((fStrToFloat(edtValor.Text) / fltValTot) * 100);
      end;

      If Not FDatasetCtpDet.FieldByname('INCREMENTO').AsString.IsEmpty Then
        FDatasetCtpDet.FieldByName('TIPOACAO').AsString := '2';

      FDatasetCtpDet.Post;
    End;
  End;

  pAtualizaTemporariaCtpDet;
  blnAltera := False;
  pLimpaEdits;
  pSetFocus(fraPlanoDeContas.MskCodCta);
  FDatasetCtpDet.Last;
  blnMudarFoco := False;
end;

procedure TfrmDesmembrValores.FormShow(Sender: TObject);
begin
  inherited;
  AAtualiza := False;
  dtsCtpDet := TDataSource.Create(Self);
  dtsCtpDet.DataSet := FDatasetCtpDet;
  dbgValores.DataSource := dtsCtpDet;

  If Assigned(FDatasetCtpDet) then
  Begin
    If FDatasetCtpDet.Active Then
    Begin
      If FDatasetCtpDet.RecordCount > 0 then
      Begin
        cdsCtpDetBkp := TUniClientDataSet.Create(nil);
        cdsCtpDetBkp.Data := FDatasetCtpDet.Data ;
      End;
    End;
  End;

  FDatasetCtpDet.Filter := 'TIPOACAO<>''3'' ';
  FDatasetCtpDet.Filtered := True;

  pAtribuiTabelas;

  {*****************************************}
  {* ABRE A TEMPORARIA E ATUALIZA O VALOR  *}
  {**************************************MV*}
  pAtualizaTemporariaCtpDet;
  pCalculaValDup;

  edtDiferenca.Clear;

  edtDiferenca.Text := '0,00';
  edtPercDiferenca.Text := '0,00';

  {*****************************************}
  {* TRAZ A EMPRESA ATUAL COMO SUGESTÃO    *}
  {**************************************MV*}
  edtCodEmp.Text := VS_strCodEmp;
  SetLength(FEmpresasSelecionadas,1);
  FEmpresasSelecionadas[0].strCodigo := edtCodEmp.Text;
  pCarregaEmpresa;

  edtPercGeral.Text  := '100,00';

  If (Not blnEntMer) Then
  Begin

    If (Not blnGerAut) Then
    Begin
      If FDatasetCtpDet.IsEmpty Then
      Begin
        rdbValor.Checked := True;
        lblTipo.Caption   := 'Valor:';
        edtTotGeral.Text  := FormatFloat('#,##0.00',fltValTot);
        edtTotDup.Text    := FormatFloat('#,##0.00',fltValTot);
        pnlTipo.Enabled   := True;
      End
      Else
      Begin
        rdbValor.Checked  := True;
        lblTipo.Caption   := 'Valor:';
        edtTotGeral.Text  := FormatFloat('#,##0.00',fltValTot);
        edtTotDup.Text    := FormatFloat('#,##0.00',fltValTot);
        pnlTipo.Enabled   := True;
      End;
    End
    Else
      fValidaCampos(rdbPorcen, True);

  End
  Else
  Begin

    If (Not blnGerAut) Then
    Begin
      If FDatasetCtpDet.IsEmpty Then
      Begin
        rdbValor.Checked  := True;
        lblTipo.Caption   := 'Valor:';
        edtTotGeral.Text  := FormatFloat('#,##0.00',fltValTot);
        edtTotDup.Text    := FormatFloat('#,##0.00',fltValTot);
      End Else
      Begin
        lblTipo.Caption   := 'Valor:';
        edtTotGeral.Text  := FormatFloat('#,##0.00',fltValTot);
        edtTotDup.Text    := FormatFloat('#,##0.00',fltValTot);
        pnlTipo.Enabled   := False;
      End;
    End
    Else
    Begin
      rdbPorcen.Checked := True;
      lblTipo.Caption   := 'Percentual:';
      pnlTipo.Enabled   := False;
    End;

  End;

  If blnBaixada Then
  Begin
    btnConfirma.Visible := false;
    pnlTipo.Visible     := False;
    pnlDados.Visible    := False;
    dbgValores.ReadOnly := True;
    If blnEntMer Then
    Begin
      btnConfirma.Visible      := True;
      btnMarDes.Visible        := False;
      btnAlteraCC.Visible      := False;
      btnDesmarcaTodos.Visible := False;
    End;
  End;

  if blnEntMerAut then
  begin
    chkEventos.Checked := True;
    edtCodEmp.ReadOnly := True;
    fraCentroCusto.edtCodEve.ReadOnly := true;
    fraPlanoDeContas.mskCodCta.ReadOnly := True;
    btnAlteraCC.Enabled := False;
    btnMarDes.Enabled := False;
    btnDesmarcaTodos.Enabled := False;

  end;

 // pAtualizaTemporariaCtpDet;
end;

procedure TfrmDesmembrValores.patribuiTabelas;
begin
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

procedure TfrmDesmembrValores.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if blnEntMerAut then
  begin
    chkEventos.Checked := True;
    edtCodEmp.ReadOnly := True;
    fraCentroCusto.edtCodEve.ReadOnly := true;
    fraPlanoDecontas.mskCodCta.ReadOnly := True;
    btnAlteraCC.Enabled := False;
    btnMarDes.Enabled := False;
    btnDesmarcaTodos.Enabled := False;
  end;

  FDatasetCtpDet.Filtered := False;
  If FDatasetCtpDet.IsEmpty Then
  Begin
    fMensagem('', 'Sem dados para cancelar!', ['&O k']);

    FDatasetCtpDet.Filtered := True;
    Exit;
  End;
  FDatasetCtpDet.Filtered := True;

  if fMensagem('ATENÇÃO', 'Deseja Cancelar Inserção/Alteração dos Desmembramentos? ', ['&Sim', '&Não']) = 2 Then
    Exit;

  FDatasetCtpDet.First;
  FDatasetCtpDet.Close;
  pAtualizaTemporariaCtpDet;
  pCalculaValDup;
  edtDiferenca.Text     := '0,00';
  edtPercDiferenca.Text := '0,00';
  edtTotGeral.Text      := FormatFloat('#,##0.00',fltValTot);
  edtTotDup.Text        := FormatFloat('#,##0.00',fltValTot);
  edtPercDup.Text       := '100,00';
  pLimpaEdits;
end;

procedure TfrmDesmembrValores.btnConfirmaClick(Sender: TObject);
Var SprcScroll: TprcScroll;
begin
  inherited;
  If btnConfirma.Visible = False Then
    Exit;

  If blnBaixada And blnEntMer Then
  Begin
    Close;
    Exit;
  End;

  pDisableControls(FDatasetCtpDet, SprcScroll);
  try
    pAtualizaTemporariaCtpDet;
    strCodCta := '';
    If fVerificaSeTodasContasSaoIguais(FDatasetCtpDet) Then
      strCodCta := FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString;

    strCodEve := '';
    If fVerificaSeTodosEventosSaoIguais(FDatasetCtpDet) Then
      strCodEve := FDatasetCtpDet.FieldByName('CTP_CODEVE').AsString;

    If (Not FDatasetCtpDet.IsEmpty) And (edtDiferenca.Text <> '0,00') And (edtPercDiferenca.Text <> '0,00') Then
    Begin
      fMensagem('', 'Valores inválidos!' + #13#10 + 'O Valor da Diferença deverá ser sempre zero ao confirmar o desmembramento!', ['&O k']);
      Exit;
    End
    Else
      begin
        Close;
      end;
  finally
    pEnableControls(FDatasetCtpDet, SprcScroll);
    FDatasetCtpDet.First;
  end;
end;

{*****************************************}
{* CALCULA O TOTAL DIGITADO              *}
{**************************************MV*}
function TfrmDesmembrValores.fCalculaTotal: Double;
  Var
    fltSoma: Double;
begin

  If Not fEmptyStr(strDuplGerAut) And Not fEmptyStr(strParcGerAut) Then
  Begin
    FDatasetCtpDet.Filtered := False;
    FDatasetCtpDet.Filter   := ' CTP_NUMDUP = ' + QuotedStr(strDuplGerAut) + ' AND ' +
                               ' CTP_PARCEL = ' + QuotedStr(strParcGerAut) + ' AND ' +
                               ' TIPOACAO <> ''3'' ';
    FDatasetCtpDet.Filtered := True;
  End;

  With FDatasetCtpDet Do
  Begin
    First;

    fltSoma           := 0;
    fltSomaPercentual := 0;
    While Not Eof Do
    Begin
      fltSoma           := fltSoma + FieldByName('CTP_VALDUP').AsFloat;
      fltSomaPercentual := fltSomaPercentual + FieldByName('PERCENTUAL').AsFloat;
      Next;
    End;
  End;

  If Not fEmptyStr(edtTotGeral.Text) Then
  Begin
    If (fFormataFloat(fltSoma, 2) = fFormataFloat(StrToFloat(AnsiReplaceStr(edtTotGeral.Text, '.', '')), 2)) Then
    Begin
      If fltSomaPercentual < 100 Then
        fltSomaPercentual := 100;
    End;
  End;

  Result := fltSoma;
end;

procedure TfrmDesmembrValores.pCalculaValDup;
var
  fltTotDup: Double;
begin

  {*****************************************}
  {* CASO NÃO TENHA NENHUM REGISTRO, NÃO   *}
  {* FAZ NADA                              *}
  {**************************************MV*}
  If (Not FDatasetCtpDet.Active) Or
     (FDatasetCtpDet.IsEmpty)    Then
  Begin
    Exit;
  End;

  fltTotDup := 0;
  With FDatasetCtpDet Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;

      If Not blnGerAut Then
      Begin
        FieldByName('CTP_VALDUP').AsFloat := fFormataFloat((fltValTot * FieldByName('CTP_FATCAL').AsFloat), 2);

        If FDatasetCtpDet.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
          FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat := (FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat * -1);

        FieldByName('PERCENTUAL').AsFloat := FieldByName('CTP_FATCAL').AsFloat * 100;

        If FDatasetCtpDet.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
          FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat := (FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat * -1);
      End
      Else
        FieldByName('CTP_VALDUP').AsFloat := FieldByName('CTP_FATCAL').AsFloat * 100;

      fltTotDup := fltTotDup + FieldByName('CTP_VALDUP').AsFloat;

      Post;

      Next;
    End;

    Filtered := False;
    Filter   := ' PERCENTUAL <> 0 AND TIPOACAO <> ''3'' ';
    Filtered := True;

    If not IsEmpty Then
    Begin
      RecNo := RecordCount;

      if fltTotDup <>  fltValTot then
      begin
        edit;
        FieldByName('CTP_VALDUP').AsFloat :=  fltValTot - (fltTotDup-FieldByName('CTP_VALDUP').AsFloat);
        post;
      end;
    end;

    Filtered := False;
    Filter   := 'TIPOACAO <> ''3'' ';
    Filtered := True;
  End;

end;

procedure TfrmDesmembrValores.pCalculaFatCal;
begin
  fltValTot := fCalculaTotal;

  If fltValTot <> 0 Then
  Begin
    FDatasetCtpDet.First;
    While Not FDatasetCtpDet.Eof Do
    Begin
      FDatasetCtpDet.Edit;
      FDatasetCtpDet.Edit;
      FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat := fFormataFloat(FDatasetCtpDet.FieldByName('CTP_VALDUP').AsFloat,2) / fltValTot;

      If FDatasetCtpDet.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
        FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat := (FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat * -1);

      FDatasetCtpDet.Post;

      FDatasetCtpDet.Next;

    End;

  End;

end;

{*****************************************}
{* VERIFICA SE EXISTE ALGUM REGISTRO NA  *}
{* TEMPORARIA COM OS MESMOS DADOS QUE O  *}
{* USUÁRIO DIGITOU. RETORNA TRUE SE ESTÁ *}
{* TUDO OK.                              *}
{**************************************MV*}
function TfrmDesmembrValores.fValidaValores(strCodConta: String = ''): Boolean;
  Var
    cdsTemp: TUniClientDataSet;
begin

  Try
    Result := True;

    cdsTemp := TUniClientDataSet.Create(Self);
    cdsTemp.Data := FDatasetCtpDet.Data;

    With cdsTemp Do
    Begin
      Filtered := False;
      If Not fEmptyStr(strDuplGerAut) And Not fEmptyStr(strParcGerAut) Then
      Begin
        if fEmptyStr(strCodConta) then
        begin
          Filter := 'CTP_CODEMP = ' + QuotedStr(edtCodEmp.Text) + ' AND CTP_CODEVE = ' + QuotedStr(fraCentroCusto.edtCodEve.Text) +
                    ' AND CTP_CODCTA = ' + QuotedStr(fraPlanoDeContas.MskCodCta.Text) + ' AND CTP_NUMDUP = ' + QuotedStr(strDuplGerAut) +
                    ' AND CTP_PERCEL = ' + QuotedStr(strParcGerAut) +
                    ' AND TIPOACAO <> ''3'' ';
        end
        else
        begin
          Filter := 'CTP_CODEMP = ' + QuotedStr(edtCodEmp.Text) + ' AND CTP_CODEVE = ' + QuotedStr(fraCentroCusto.edtCodEve.Text) +
                  ' AND CTP_CODCTA = ' + QuotedStr(strCodConta) + ' AND CTP_NUMDUP = ' + QuotedStr(strDuplGerAut) +
                  ' AND CTP_PERCEL = ' + QuotedStr(strParcGerAut) +
                  ' AND TIPOACAO <> ''3'' ';
        end;
      End
      Else
      Begin
        if fEmptyStr(strCodConta) then
        begin
          Filter := 'CTP_CODEMP = ' + QuotedStr(edtCodEmp.Text) + ' AND CTP_CODEVE = ' + QuotedStr(fraCentroCusto.edtCodEve.Text) +
                    ' AND CTP_CODCTA = ' + QuotedStr(fraPlanoDeContas.MskCodCta.Text) +
                    ' AND TIPOACAO <> ''3'' ';
        end
        else
        begin
          Filter := 'CTP_CODEMP = ' + QuotedStr(edtCodEmp.Text) + ' AND CTP_CODEVE = ' + QuotedStr(fraCentroCusto.edtCodEve.Text) +
                    ' AND CTP_CODCTA = ' + QuotedStr(strCodConta) +
                    ' AND TIPOACAO <> ''3'' ';
        end;
      End;
      Filtered := True;

      If RecordCount > 0 Then
      begin
        fltValorAnterior := FieldByName('CTP_VALDUP').AsFloat;
        fltPercentualAnt := FieldByName('PERCENTUAL').AsFloat;
        Result := False;
      end;
    End;

  Finally
    FreeAndNil(cdsTemp);
  End;

end;

procedure TfrmDesmembrValores.pTestaMarcados;
  Var
    cdsGenDet: TUniClientDataSet;

    LPosicaoAtual: Integer;
begin
  LPosicaoAtual := FDatasetCtpDet.RecNo;

  cdsGenDet := fCriaClientDatSet(FDatasetCtpDet);
  FDatasetCtpDet.RecNo := LPosicaoAtual;

  Try
    cdsGenDet.Filtered := False;
    cdsGenDet.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND TIPOACAO<>''3'' ';
    cdsGenDet.Filtered := True;

    If cdsGenDet.RecordCount = 0 Then
      strCtaMar := '';
  Finally
    cdsGenDet.Close;
    FreeAndNil(cdsGenDet);
  End;

End;

procedure TfrmDesmembrValores.pDesmarcaTodos;
  Var
    LprcScroll: TprcScroll;
begin

  pDisableControls(FDatasetCtpDet, LprcScroll);

  FDatasetCtpDet.First;
  While Not FDatasetCtpDet.Eof Do
  Begin
    FDatasetCtpDet.Edit;
    FDatasetCtpDet.FieldByName('CTP_MARDES').AsString := 'D';
    FDatasetCtpDet.Post;

    FDatasetCtpDet.Next;
  End;

  pEnableControls(FDatasetCtpDet, LprcScroll);

  pAtualizaTemporariaCtpDet;
End;

procedure TfrmDesmembrValores.pEscolheCentroCustoParaMarcar;
Var
  frmCentroCusto: TfrmDigCentroCusto;
begin
  pCriarFormularios(TfrmDigCentroCusto, frmCentroCusto);
  FPlanoContasSelecionadoParaMarcarTodos := '';

  If frmCentroCusto.ShowModal = mrok Then
  Begin
    FPlanoContasSelecionadoParaMarcarTodos := frmCentroCusto.fraPlanoDeContas.MskCodCta.Text;
    strCtaMar := frmCentroCusto.fraPlanoDeContas.MskCodCta.Text;
  End;

  FreeAndNil(frmCentroCusto);
end;

procedure TfrmDesmembrValores.pMarcaItemAlteracao;
Begin
  pTestaMarcados;

  If Not FDatasetCtpDet.IsEmpty Then
  Begin

    If (FDatasetCtpDet.FieldByName('CTP_MARDES').AsString = 'M') Or
       fEmptyStr(strCtaMar) Or
       (FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString = strCtaMar) Then
    Begin

      If (FDatasetCtpDet.FieldByName('CTP_MARDES').AsString <> 'M') Then
        strCtaMar := FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString;

      pMarcaDesmarcaCtpDet;
    End

    Else pMensagemOk('É permitido selecionar somente registros que possuem o mesmo Plano de Contas!');

  End;

End;

procedure TfrmDesmembrValores.pMarcarTodos;
Var
  LprcScroll: TprcScroll;
begin
  pEscolheCentroCustoParaMarcar;

  If FPlanoContasSelecionadoParaMarcarTodos.IsEmpty Then
    Exit;

  pDisableControls(FDatasetCtpDet, LprcScroll);
  FDatasetCtpDet.First;
  While Not FDatasetCtpDet.Eof Do
  Begin
    If FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString = FPlanoContasSelecionadoParaMarcarTodos Then
    Begin
      FDatasetCtpDet.Edit;
      FDatasetCtpDet.FieldByName('CTP_MARDES').AsString := 'M';
      FDatasetCtpDet.Post;
    End
    Else
    Begin
      FDatasetCtpDet.Edit;
      FDatasetCtpDet.FieldByName('CTP_MARDES').AsString := 'D';
      FDatasetCtpDet.Post;
    End;

    FDatasetCtpDet.Next;
  End;

  pEnableControls(FDatasetCtpDet, LprcScroll);
  pAtualizaTemporariaCtpDet;
End;

procedure TfrmDesmembrValores.pMarcaDesmarcaCtpDet;
  Var
    LPosicaoAtual: Integer;

    LprcScroll: TprcScroll;
begin
  LPosicaoAtual := FDatasetCtpDet.RecNo;

  pDisableControls(FDatasetCtpDet, LprcScroll);

  Try
    FDatasetCtpDet.Edit;

    If FDatasetCtpDet.FieldByName('CTP_MARDES').AsString <> 'M' Then
      FDatasetCtpDet.FieldByName('CTP_MARDES').AsString := 'M'
    Else
      FDatasetCtpDet.FieldByName('CTP_MARDES').AsString := 'D';

    FDatasetCtpDet.Post;

    pAtualizaTemporariaCtpDet;
  Finally
    FDatasetCtpDet.RecNo := LPosicaoAtual;

    pEnableControls(FDatasetCtpDet, LprcScroll);
  End;
End;

procedure TfrmDesmembrValores.dbgValoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

begin
  inherited;
  If (Not blnBaixada) Then
  Begin
    If (Key = VK_Delete) And (Not FDatasetCtpDet.IsEmpty) Then
    Begin
      If (FDatasetCtpDet.RecordCount > 0) And
         (fMensagem('', 'Confirma exclusão da Conta?', ['&Sim', '&Não']) = 1) Then
      Begin
        pDeletaRegistro;
        pAtualizaTemporariaCtpDet;
      End;
    End;
    If Key = VK_Return Then
      dbgValoresDblClick(Sender);

    If Key = VK_SPACE Then
      btnMarDes.Click;

  End;
end;

function TfrmDesmembrValores.DivergenciaDeValores: Boolean;
  Var
    LPorcentagem : Double;
    LRecNo : Integer;
begin
  Result := False;
  LPorcentagem := 0;

  If Not Assigned(FDatasetCtpDet) Then
    Exit;

  If FDatasetCtpDet.IsEmpty Then
    Exit;

  Try
    LRecNo := FDatasetCtpDet.RecNo;
    FDatasetCtpDet.First;
    While Not FDatasetCtpDet.Eof Do
    Begin
      LPorcentagem := (LPorcentagem + FDatasetCtpDet.FieldByName('PERCENTUAL').AsFloat);
      FDatasetCtpDet.Next;
    End;

    If (edtDiferenca.Text = '0,00') Then
    Begin
      If (fFormataFloat(LPorcentagem,2) < 100.00) Then
        LPorcentagem := 100;
    End;

    If (fFormataFloat(LPorcentagem,2) <> 100.00) Then
      Result := True ;

    FDatasetCtpDet.RecNo := LRecNo;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message)
    End;
  End;

end;

{*****************************************}
{* DELETA A CONTA QUE ESTÁ POSICIONADA   *}
{* NA TELA                               *}
{**************************************MV*}
procedure TfrmDesmembrValores.pDeletaRegistro;
begin
  If FDatasetCtpDet.FieldByName('TIPOACAO').AsString.Equals('1') Then
  Begin
    FDatasetCtpDet.Delete;

    Exit;
  End;

  FDatasetCtpDet.Edit;
  FDatasetCtpDet.FieldByName('TIPOACAO').AsString := '3';
  FDatasetCtpDet.Post;
end;

procedure TfrmDesmembrValores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  
//  inherited;

  If (Key = VK_F10) And (pnlDados.Enabled) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;
  If (Key = VK_Escape) Then
  Begin
    If Not pnlDados.Enabled Then
    Begin
      Close;
      Exit;
    End;

    If (dbgValores.Focused) And (Not blnBaixada) Then
    Begin
      pLimpaEdits;
      pSetFocus(fraPlanoDeContas.MskCodCta);
      pAtualizaTemporariaCtpDet;
    End;
  End;

end;

procedure TfrmDesmembrValores.FormClose(Sender: TObject; var Action: TCloseAction);
Var SprcScroll: TprcScroll;
begin
  inherited;

  pDisableControls(FDatasetCtpDet, SprcScroll);
  try
    If DivergenciaDeValores Then
    Begin
      If Assigned(cdsCtpDetBkp) Then
      Begin
        if fMensagem('', 'O Valor ou Percentual da Diferença não poderá ser diferente de zero! ' + #13 +
                         'As alterações no desmembramento serão desconsideradas! ' + #13 + ' Continuar ?', ['&S i m', '&N ã o']) = 1 Then
        Begin
          FDatasetCtpDet.EmptyDataSet;
          FDatasetCtpDet.Data := cdsCtpDetBkp.Data;
        End
        Else
          System.SysUtils.Abort;
      End
      Else
      Begin
        fMensagem('', 'O Valor ou Percentual da Diferença não poderá ser diferente de zero! ', ['&O k']);
        System.SysUtils.Abort;
      End;
    End;

    pDesmarcaTodos;
    pCalculaFatCal;
    pAtualizaTemporariaCtpDet;
    if (not FDatasetCtpDet.IsEmpty) and (strCodCta.IsEmpty) then
    Begin
      strCodCta := '';
      If fVerificaSeTodasContasSaoIguais(FDatasetCtpDet) Then
        strCodCta := FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString;
    End;

    if (not FDatasetCtpDet.IsEmpty) and (strCodEve.IsEmpty) then
    Begin
      strCodEve := '';
      If fVerificaSeTodosEventosSaoIguais(FDatasetCtpDet) Then
        strCodEve := FDatasetCtpDet.FieldByName('CTP_CODEVE').AsString;
    End;

  finally
    FDatasetCtpDet.Filter := '';
    FDatasetCtpDet.Filtered := False;
    pEnableControls(FDatasetCtpDet, SprcScroll);
  end;

  If Assigned(cdsCtpDetBkp) Then
    cdsCtpDetBkp.Free;
end;

{*****************************************}
{* LIMPA ALGUNS COMPONENTES DA TELA      *}
{**************************************MV*}
procedure TfrmDesmembrValores.pLimpaEdits;
begin
  fraPlanoDeContas.MskCodCta.Clear;
  edtValor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  pSetFocus(fraPlanoDeContas.MskCodCta);
end;

procedure TfrmDesmembrValores.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if blnEntMerAut then
    Exit;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, FEmpresasSelecionadas, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDesmembrValores.dbgValoresDblClick(Sender: TObject);
begin
  inherited;
  If (Not FDatasetCtpDet.IsEmpty) And (Not blnBaixada) Then
  Begin
    blnAltera := True;
    blnGrid := True;
    fraPlanoDeContas.MskCodCta.Text := FDatasetCtpDet.fieldbyname('CTP_CODCTA').AsString;

    If FDatasetCtpDet.fieldbyname('CTP_DEBCRE').AsString.Equals('D')  Then
    Begin
      rdbValor.Checked := True;
      rdbValorClick(rdbValor);
      rdbPorcen.Enabled := False;
    End
    Else If FDatasetCtpDet.fieldbyname('CTP_DEBCRE').AsString.Equals('C') Then
      rdbPorcen.Enabled := True;


    IF rdbValor.Checked then
      edtValor.Text  := FormatFloat('#,##0.00',FDatasetCtpDet.fieldbyname('CTP_VALDUP').AsFloat)
    else
      edtValor.Text  := FormatFloat('#,##0.00',FDatasetCtpDet.fieldbyname('PERCENTUAL').AsFloat);

    fraPlanoDeContas.edtDesCta.Text := FDatasetCtpDet.fieldbyname('CTA_DESCTA').AsString;
    edtCodEmp.Text := FDatasetCtpDet.fieldbyname('CTP_CODEMP').AsString;
    fraCentroCusto.edtCodEve.Text := FDatasetCtpDet.fieldbyname('CTP_CODEVE').AsString;
    pCarregaEventos;

    if blnEntMerAut then
      pSetFocus(edtValor)
    else
      pSetFocus(fraPlanoDeContas.MskCodCta);
  End;
end;

procedure TfrmDesmembrValores.chkEventosClick(Sender: TObject);
begin
  inherited;
  pMostraEventos(chkEventos.Checked);
end;

procedure TfrmDesmembrValores.pCarregaEventos;
begin
  fraCentroCusto.edtDesEve.Clear;
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
end;

function TfrmDesmembrValores.fVerificaItensEventos : Boolean;
  Var
    cdsGenDet: TUniClientDataSet;
begin
  Try

    cdsGenDet := fCriaClientDatSet(FDatasetCtpDet);
    cdsGenDet.Open;

    Result := False;

    cdsGenDet.Filtered := False;
    cdsGenDet.Filter   := 'CTP_CODEVE <> ' + QuotedStr('') + ' AND CTP_CODEVE IS NOT NULL AND TIPOACAO <> ''3'' ';
    cdsGenDet.Filtered := True;

    If Not cdsGenDet.IsEmpty Then
      Result := True;

  Finally
    FreeAndNil(cdsGenDet);
  End;


end;

procedure TfrmDesmembrValores.pMostraEventos(blnMostra : Boolean);
begin

  If Not blnMostra Then
  Begin
    fraCentroCusto.Visible := False;
    dbgValores.Columns[1].Visible := False;
    pnlDados.Height    := 106;
    btnInserir.Top     := edtValor.Top;
    btnInserir.Left    := edtValor.Left + edtValor.Width + 1;
  End
  Else
  Begin
    fraCentroCusto.Visible := True;
    dbgValores.Columns[1].Visible := True;
    pnlDados.Height    := 133;
    btnInserir.Top     := fraCentroCusto.Top;
    btnInserir.Left    := edtValor.Left - 1;
  End;

end;

procedure TfrmDesmembrValores.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmDesmembrValores.btnMarDesClick(Sender: TObject);
begin
  inherited;
  pMarcaItemAlteracao;
end;

procedure TfrmDesmembrValores.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcaTodos;
end;

procedure TfrmDesmembrValores.btnInserirClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos And blnInsere And Not blnAltera Then
  Begin
    pAdicionaRegistro;
    pSetFocus(fraPlanoDeContas.MskCodCta);
    pLimpaEdits;
    blnMudarFoco := False;
    blnAltera := False;
    blnInsere := True;
  End;
end;

procedure TfrmDesmembrValores.dbgValoresDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If FDatasetCtpDet.FieldByName('CTP_MARDES').AsString = 'M' then
  Begin
    dbgValores.Canvas.Brush.Color:= clMoneyGreen;
    dbgValores.Canvas.FillRect(Rect);
  End;

  dbgValores.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmDesmembrValores.btnAlteraCCClick(Sender: TObject);
begin
  inherited;

  pAlteraCentroCusto;

end;

procedure TfrmDesmembrValores.pUpdateCentroCusto(strCodConta: String);
begin
  If Not fValidaValores(strCodConta) Then
  Begin
    blnAltera := True;
    blnInsere := False;

    IF NOT fEmptyStr(strCodCta) then
    begin
      fMensagem('', 'Já existe um plano de contas com esses dados! Informe outro.', ['&O k']);
      strCodConta := '';
      FreeAndNil(frmDigCentroCusto);
      btnAlteraCCClick(Nil);
    end
    else
    begin
      pLimpaEdits;
      Exit;
    end;
  End;

  if not fEmptyStr(strCodConta) then
  begin
    FDatasetCtpDet.Filtered := False;
    FDatasetCtpDet.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND TIPOACAO <> ''3'' ';
    FDatasetCtpDet.Filtered := True;

    FDatasetCtpDet.First;

    While Not FDatasetCtpDet.Eof do
    Begin
       If Assigned(FValidaCorrespondenteContabil) And
          Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(strCodConta, FDatasetCtpDet.FieldByName('CTP_CODEMP').AsString) Then
      Begin
        FDatasetCtpDet.Next;
        Continue;
      End;

      FDatasetCtpDet.Edit;

      FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString := strCodConta;
      FDatasetCtpDet.FieldByName('CTA_DESCTA').AsString := fRetNomeConta(strCodConta);

      If Not FDatasetCtpDet.FieldByName('INCREMENTO').AsString.IsEmpty Then
        FDatasetCtpDet.FieldByName('TIPOACAO').AsString := '2';

      FDatasetCtpDet.Post;

      FDatasetCtpDet.Next;
    End;

    FDatasetCtpDet.Filter := ' TIPOACAO <> ''3'' ';
    FDatasetCtpDet.Filtered := True;
  end;

End;

procedure TfrmDesmembrValores.rdbValorClick(Sender: TObject);
begin
  inherited;

  If rdbPorcen.Checked Then
    lblTipo.Caption  := 'Percentual: '
  Else
    lblTipo.Caption := 'Valor: ';

  edtTotGeral.Text      := FormatFloat('#,##0.00',fltValTot);
  edtPercGeral.Text     := '100,00';
end;

procedure TfrmDesmembrValores.pAlteraCentroCusto;
Begin
  pTestaMarcados;
  If fEmptyStr(strCtaMar) Then
  Begin
    pMensagemOk('Selecione os registros para alteração!');
    Exit;
  End;

  pCriarFormularios(TfrmDigCentroCusto, frmDigCentroCusto);
  If frmDigCentroCusto.ShowModal = mrok Then
  Begin
    strCodCta := frmDigCentroCusto.fraPlanoDeContas.MskCodCta.Text;
    pUpdateCentroCusto(strCodCta);
    pDesmarcaTodos;
    pLimpaEdits;
  End;

  FreeAndNil(frmDigCentroCusto);
End;

Procedure TfrmDesmembrValores.DesabilitaTodosBotoes();
Begin

 btnconfirma.Enabled      := False;
 btncancela.Enabled       := False;
 btnMarDes.Enabled        := False;
 btnAlteraCC.Enabled      := False;
 btnDesmarcaTodos.Enabled := False;
 dbgValores.enabled       := False;

End;

end.


