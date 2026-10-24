unit Contabilidade.View.ApuracaoLucroRealLalurLacsAjustesAlterar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus,
  cxCurrencyEdit, CurrencyEditFocus, MemoFocus, cxGroupBox, cxRadioGroup,
  Vcl.Mask, MaskEditFocus, Data.DB, MemDS, DBAccess, Uni, Contabilidade.Interfaces ;

type
  TfrmApuracaoLucroRealLalurLacsAjustesAlterar = class(TfrmPaiConfirmaContabilidade)
    edtARE_DTALAN: TcxDateEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    edtARE_HISPAD: TEditFocus;
    edtDesPad: TEditFocus;
    cxLabel3: TcxLabel;
    edtARE_HISTOR: TMemoFocus;
    cxLabel4: TcxLabel;
    edtARE_VALLAN: TCurrencyEditFocus;
    cxLabel5: TcxLabel;
    edtDesCon: TEditFocus;
    rgARE_TIPLAN: TRadioGroup;
    edtARE_CODCON: TMaskEditFocus;
    cxLabel6: TcxLabel;
    edtARE_NATAJU: TEditFocus;
    edtDesAju: TEditFocus;
    rgARE_CREDEB: TRadioGroup;
    procedure edtARE_HISPADKeyPress(Sender: TObject; var Key: Char);
    procedure edtARE_CODCONKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FdtaVigenciaInicial: TDateTime ;
    FdtaVigenciaFinal: TDateTime ;
    FBlnExisteCampoNCO_NATURE: boolean ;
    FStrAutoIncAjuste: string ;
    FStrCodigoApuracao: string ;
    FllTipo: TLacsLalur ;
    FstrCodEmp: String ;
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean);
    function fValidaDadosInformados:boolean ;
    function fValidaContaContabil: boolean ;
    procedure pAtualizaCtrlsNaturezaAjuste(const AStrConta, AStrTpLaCo: string) ;
  public
    { Public declarations }
    property VigenciaInicial: TDateTime read FdtaVigenciaInicial write FdtaVigenciaInicial ;
    property VigenciaFinal: TDateTime read FdtaVigenciaFinal write FdtaVigenciaFinal ;
    property AutoIncAjuste: string read FStrAutoIncAjuste write FStrAutoIncAjuste ;
    property CodigoApuracao: string read FStrCodigoApuracao write FStrCodigoApuracao ;
    property Tipo: TLacsLalur read FllTipo write FllTipo ;
    property CodEmp: String read FstrCodEmp write FstrCodEmp;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, Contabilidade.Consultas,
     Contabilidade.Funcoes, Contabilidade.Classes.ApuracaoLucroRealLalurLacs ;

{ TfrmApuracaoLucroRealLalurLacsAjustesAlterar }

procedure TfrmApuracaoLucroRealLalurLacsAjustesAlterar.btnConfirmaClick(
  Sender: TObject);
begin
  if not fValidaDadosInformados then
  begin
    exit ;
  end;

  ModalResult := mrOK ;

  inherited;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_CODCONKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(FstrCodEmp) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, edtARE_CODCON, edtDesCon, Nil, Key, arrPlan, True, strTplaco, not FBlnExisteCampoNCO_NATURE, 'S', True, '"A","E"', iif(FllTipo = llLacs, 'S', ''), iif(FllTipo = llLalur, 'S', '')) Then
    begin
      If fValidaCampos(edtARE_CODCON, True) Then
        SelectNext(ActiveControl, True, True);
    end;
  End;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_HISPADKeyPress(
  Sender: TObject; var Key: Char);
var
  arrHisPad : TConsultasArray;
begin
  inherited;
  If fPesqHistoricoPadrao(Self, edtARE_HISPAD, edtDesPad, Nil, Key, arrHisPad, True, CodEmp) Then
  Begin
    If fValidaCampos(edtARE_HISPAD, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustesAlterar.FormCreate(
  Sender: TObject);
var
  strMascara: String ;
begin
  inherited;
  strMascara := fMskCon;
  edtARE_CODCON.EditMask := strMascara;
  FBlnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');
end;

function TfrmApuracaoLucroRealLalurLacsAjustesAlterar.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtARE_CODCON) Then
    Begin
      pCarregaPlanoContabil(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(edtARE_CODCON.Text))) And (fEmptyStr(edtDesCon.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta Contabil Inválida!',['&OK']);
        Result := False;
      end
      else if (Not fEmptyStr(fSemMascaraPlaNco(edtARE_CODCON.Text))) then
      begin
        result := fValidaContaContabil ;
        if not result then
        begin
          edtDesCon.Clear ;
        end;
      end;
    End
    else if (Sender = edtARE_HISPAD) then
    begin
      If Not fEmptyStr(edtARE_HISPAD.Text) Then
      Begin
        edtDesPad.Text := fCarregaHistoricoPadrao(edtARE_HISPAD.Text, CodEmp);
        If fEmptyStr(edtDesPad.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse histórico padrão não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesPad.Clear;
      End;

    end ;
  End ;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmApuracaoLucroRealLalurLacsAjustesAlterar.fValidaContaContabil: boolean;
var
  LStrTplaco: string ;
  LStrNatAju: string ;
  LStrTipMov: string ;
  LStrAjuLiq: string ;
  LStrNatAjuLacs: string ;
  LStrNatAjuLalur: string ;
begin
  result := False ;
  if FBlnExisteCampoNCO_NATURE then
  begin
    LStrTplaco := fRetTplacoEmpresaLogada(FstrCodEmp) ;
    if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(edtARE_CODCON.Text), LStrTplaco]) = 'S') then
    begin
      fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
      exit ;
    end;
  end;

  LStrAjuLiq := vartostr(fCampoTabela('NCO_AJULIQ', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(edtARE_CODCON.Text), LStrTplaco])) ;
  if LStrAjuLiq <> 'S' then
  begin
    fMensagem('ATENÇÃO!','Conta Contabil não representa ajuste do lucro líquido!',['&OK']);
    exit ;
  end;

  LStrNatAju := vartostr(fCampoTabela('NCO_NATAJU', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(edtARE_CODCON.Text), LStrTplaco])) ;
  if fEmptyStr(LStrNatAju) then
  begin
    fMensagem('ATENÇÃO!','Conta Contabil sem Natureza de Ajuste!',['&OK']);
    exit ;
  end;

  LStrTipMov := fCampoTabela('NAT_TIPMOV', 'NATAJU', ['NAT_CODIGO'], [LStrNatAju]) ;
  if pos(LStrTipMov,'_A_E') <= 0  then
  begin
    fMensagem('ATENÇÃO!','Natureza de Ajuste deve ser Adição ou Exclusão!',['&OK']);
    exit ;
  end;

  if FllTipo = llLacs then
  begin
    LStrNatAjuLacs := fCampoTabela('NAT_GERLAC', 'NATAJU', ['NAT_CODIGO'], [LStrNatAju]) ;
    if LStrNatAjuLacs <> 'S'  then
    begin
      fMensagem('ATENÇÃO!','Opção Lacs Deve Estar Selecionada na Natureza de Ajuste!',['&OK']);
      exit ;
    end;
  end;

  if FllTipo = llLalur then
  begin
    LStrNatAjuLalur := fCampoTabela('NAT_GERLAL', 'NATAJU', ['NAT_CODIGO'], [LStrNatAju]) ;
    if LStrNatAjuLalur <> 'S'  then
    begin
      fMensagem('ATENÇÃO!','Opção Lalur Deve Estar Selecionada na Natureza de Ajuste!',['&OK']);
      exit ;
    end;
  end;

  result := True ;
end;

function TfrmApuracaoLucroRealLalurLacsAjustesAlterar.fValidaDadosInformados: boolean;
begin
  result := False ;

  if fEmptyStr(edtARE_DTALAN.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Data não informada!', ['&Ok']);
    pSetFocus(edtARE_DTALAN);
    exit ;
  end;

  if not ((edtARE_DTALAN.Date >= FdtaVigenciaInicial) and (edtARE_DTALAN.Date <= FdtaVigenciaFinal)) then
  begin
    fMensagem('ATENÇÃO!', 'Data [' + edtARE_DTALAN.Text + '] fora do período [' + datetostr(FdtaVigenciaInicial) + '] a [' + datetostr(FdtaVigenciaFinal) + '] !', ['&Ok']);
    pSetFocus(edtARE_DTALAN);
    exit ;
  end;

  if fEmptyStr(edtARE_HISPAD.Text) and fEmptyStr(edtARE_HISTOR.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico Padrão/Complemento não informado!', ['&Ok']);
    pSetFocus(edtARE_HISPAD);
    exit ;
  end;

  if fEmptyStr(fSemMascaraPlaNco(edtARE_CODCON.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'Conta Contabil não informada!', ['&Ok']);
    pSetFocus(edtARE_CODCON);
    exit ;
  end;

  if fContaContabilJaCadastrada(FStrAutoIncAjuste, FStrCodigoApuracao, fSemMascaraPlaNco(edtARE_CODCON.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'Conta Contabil já informada!', ['&Ok']);
    pSetFocus(edtARE_CODCON);
    exit ;
  end;

  if edtARE_VALLAN.Value = 0.00 then
  begin
    fMensagem('ATENÇÃO!', 'Valor deve ser diferente de zero!', ['&Ok']);
    pSetFocus(edtARE_VALLAN);
    exit ;
  end;


  result := True ;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustesAlterar.pAtualizaCtrlsNaturezaAjuste(
  const AStrConta, AStrTpLaCo: string);
var
  LStrCodAju, LStrDesAju, LStrTipAju: string ;
begin
  pAtualizaInfoNaturezaAjuste(AStrConta, AStrTpLaCo, LStrCodAju, LStrDesAju, LStrTipAju) ;

  edtARE_NATAJU.Text := LStrCodAju ;
  edtDesAju.Text := LStrDesAju ;

  if fEmptyStr(LStrTipAju) then
  begin
    rgARE_TIPLAN.ItemIndex := -1 ;
  end
  else
  begin
    if LStrTipAju = 'A' then
    begin
      rgARE_TIPLAN.ItemIndex := 0 ;
      if rgARE_CREDEB.ItemIndex = -1 then
        rgARE_CREDEB.ItemIndex := 0 ;
    end
    else if LStrTipAju = 'E' then
    begin
      rgARE_TIPLAN.ItemIndex := 1 ;
      if rgARE_CREDEB.ItemIndex = -1 then
        rgARE_CREDEB.ItemIndex := 1 ;
    end;
  end;

end;

procedure TfrmApuracaoLucroRealLalurLacsAjustesAlterar.pCarregaPlanoContabil(
  const blnBuscaPorChave: Boolean);
var
  LStrTplaco : string ;
begin
  LStrTplaco := fRetTplacoEmpresaLogada(FstrCodEmp) ;
  if blnBuscaPorChave then
  begin
    edtDesCon.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(edtARE_CODCON.Text)]);
  end
  else
  begin
    edtDesCon.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(edtARE_CODCON.Text), LStrTplaco]);
  end;
  pAtualizaCtrlsNaturezaAjuste(edtARE_CODCON.Text, LStrTplaco) ;
end;

end.
