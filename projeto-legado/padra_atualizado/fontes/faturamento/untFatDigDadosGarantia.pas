unit untFatDigDadosGarantia;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils, untFuncFat,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  untConstantesNFe;

type
  TfrmFatDigDadosGarantia = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    lbl1: TLabel;
    edtClaFis: TEditFocus;
    edtDesCla: TEditFocus;
    lblSub: TLabel;
    edtClaSub: TEditFocus;
    edtDesSub: TEditFocus;
    pnlMsg: TPanel;
    lblMsg: TLabel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure edtClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

  private
    strCrePgc : String;
    procedure pDefinirPainelMsg;
    procedure pAjustarPosicaoComponente(aControl: TControl);
    function fValidarClasFisEntPedGarantia(const strClaFis: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strCodCli : string;

    fatVenda  : TFatVenda;
    strOpcDoc : String;
    blnTemST  : Boolean;
    enuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia;
    strClaFis : String;
    blnEntPedGarantia: Boolean;
    blnOperacaoInterEstadual: Boolean;

    { Public declarations }
  end;

var
  frmFatDigDadosGarantia: TfrmFatDigDadosGarantia;

implementation

uses untFuncoes, untfuncoesSimples, untConsultas;

{$R *.dfm}

function TfrmFatDigDadosGarantia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDescricao : TEditFocus;
    LCfgClaGae: String;
    strMsg: String;
begin
  Result := True;

  LCfgClaGae := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtClaFis) or ((Sender = edtClaSub) And edtClaSub.Visible) Then
    Begin
      If (Sender = edtClaFis) Then
        edtDescricao := edtDesCla
      Else
        edtDescricao := edtDesSub;

      If (fEmptyStr(TEditFocus(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação Fiscal deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        edtDescricao.Text := fRetDesCla(TEditFocus(Sender).Text);

        If fEmptyStr(edtDescricao.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Classificação Fiscal não Cadastrada!', ['&O k']);
        End;

        {***********************************}
        { GARANTIA - ENVIO PARA FORNECEDOR  }
        {********************************MM*}

        If Result And (strOpcDoc = 'GF') Then
        Begin
          LCfgClaGae := fCfgSis('CLAGAE');
          case enuTipoEnvioFornecedorGarantia of
            tefDevolucao:
              begin
                If (Pos(TEditFocus(Sender).Text, LCfgClaGae) <= 0) Then
                Begin
                  fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                        'Garantia - Envio p/ Fornecedor - Conforme definido em [CLAGAE]!', ['&O k']);
                  Result := False;
                End
              end;
            tefConserto:
              begin
                if (Pos(TEditFocus(Sender).Text, VS_strClaRGF) <= 0) then
                begin
                  fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                        'Garantia - Envio p/ Fornecedor!', ['&O k']);
                  Result := False;
                end
                else
                begin
                  If (Pos(TEditFocus(Sender).Text, CFOP_DEVOLUCAO) > 0) Then
                  Begin
                    Result := False;
                    fMensagem('', 'O CFOP informado é correspondente a Devolução!' + #13 + 'Informe um CFOP de Remessa para Conserto.', ['&OK'])
                  End;
                end;
              end;
          end;
        end

        {***********************************}
        { GARANTIA - RETORNO DE FORNECEDOR  }
        {********************************MM*}
        Else If Result And (strOpcDoc = 'GR') Then
        Begin
          If (Pos(TEditFocus(Sender).Text, VS_strClaRGR) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                  'Garantia - Retorno de Fornecedor!', ['&O k']);
            Result := False;
          End
          Else
          If StrToIntDef(LeftStr(TEditFocus(Sender).Text,1),10) >= 5 Then
          Begin
            Result := fMensagem('', 'Informe uma CFOP de entrada!', ['&OK']) = -1;
          End;

          if Result then
          begin
            if Not fValidarClasFisEntPedGarantia((TEditFocus(Sender).Text)) then
            begin
              strMsg := 'A classificação é inadequada para operação. '+slinebreak+'Informe CFOP para operação de origem de %s do estado.';

              strMsg := Format(strMsg,[ifthen(blnOperacaoInterEstadual,'fora','dentro')]);

              fMensagem('ATENÇÃO!', strMsg + #13 + 'Garantia - Retorno de Fornecedor!', ['&O k']);
              Result := False;
            end;
          end;

        End
        Else If Result And (strOpcDoc = 'OU') Then
        Begin
          If (Pos(RightStr(TEditFocus(Sender).Text, 3), strCrePgc) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                  'Reposição de Garantia do Cliente!', ['&OK']);
            Result := False;
          End
          Else
          If StrToIntDef(LeftStr(TEditFocus(Sender).Text,1),0) < 5 Then
          Begin
            Result := fMensagem('', 'Informe uma CFOP de saída!', ['&OK']) = -1;
          End;
        End

        Else If Result And (StrOpcDoc = 'GC') Then
        Begin
          If (Pos( RightStr(TEditFocus(Sender).Text,3), fCfgSis('CLAECL', varString)) <= 0) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                            'Garantia - Envio ao Cliente!', ['&O k']) = -1;
          End;
        End

        Else If (Pos(strOpcDoc, 'NE_OE_') > 0) Then
        Begin
          If (Pos( RightStr(TEditFocus(Sender).Text, 3), VS_strCreCGC) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                  'Garantia - Recebimento do Cliente!', ['&O k']);
            Result := False;
          End
          Else
          If StrToIntDef(LeftStr(TEditFocus(Sender).Text,1),10) >= 5 Then
          Begin
            Result := fMensagem('', 'Informe uma CFOP de entrada!', ['&OK']) = -1;
          End;

        End;

      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFatDigDadosGarantia.fValidarClasFisEntPedGarantia(
  const strClaFis: String): Boolean;
  const
    PREFIXO_ENTRADA_INTERESTADUAL = '2';
    PREFIXO_ENTRADA_INTERNA = '1';
  Var
    strPrefixoClaFis: String;
begin
  strPrefixoClafis := LeftStr(strClaFis, 1);
  if blnOperacaoInterEstadual then
    Result := strPrefixoClaFis = PREFIXO_ENTRADA_INTERESTADUAL
  else
    Result := strPrefixoClaFis = PREFIXO_ENTRADA_INTERNA;
end;

procedure TfrmFatDigDadosGarantia.pAjustarPosicaoComponente(aControl: TControl);
begin
  if aControl.Visible then
  begin
    aControl.Top := aControl.Top - pnlMsg.Height;
  end;
end;

procedure TfrmFatDigDadosGarantia.pDefinirPainelMsg;
begin
  if pos(strOpcDoc, '_NE_OE_') > 0 then
    lblMsg.Caption := 'Informe CFOP referente a entrada de mercadoria'
  else if pos(strOpcDoc, '_OU_') > 0 then
    lblMsg.Caption := 'Informe CFOP referente a saída de mercadoria'
  else
    pnlMsg.Visible := False;

  if pnlMsg.Visible = False then
  begin
    Self.Height := Self.Height - pnlMsg.Height;
    pAjustarPosicaoComponente(lbl1);
    pAjustarPosicaoComponente(edtClaFis);
    pAjustarPosicaoComponente(edtDesCla);
    pAjustarPosicaoComponente(lblSub);
    pAjustarPosicaoComponente(edtClaSub);
    pAjustarPosicaoComponente(edtDesSub);
  end;

end;

procedure TfrmFatDigDadosGarantia.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmFatDigDadosGarantia.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If Assigned(fatVenda) then
    Begin
      fatVenda.strClaFis := edtClaFis.Text;
      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);
    End;
    
    ModalResult := mrOk;
  End;
End;

procedure TfrmFatDigDadosGarantia.edtClaFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCFOP: TConsultasArray;
    qryConCfo: TUniQuery;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  qryConCfo := fCriaQuery(Self);
    
  If fPesqCFOP(Self, edtClaFis, edtDesCla, qryConCfo, Key, arrCFOP) Then
  Begin
    If fValidaCampos(edtClaFis, True) Then
    begin
      If Assigned(fatVenda) Then
      Begin
        If Not fEmptyStr(qryConCfo.FieldByName('CFO_MNAT01').AsString) Then
          fatVenda.strMen001 := qryConCfo.FieldByName('CFO_MNAT01').AsString;

        If Not fEmptyStr(qryConCfo.FieldByName('CFO_MNAT02').AsString) Then
          fatVenda.strMen002 := qryConCfo.FieldByName('CFO_MNAT02').AsString;

        If Not fEmptyStr(qryConCfo.FieldByName('CFO_MNAT03').AsString) Then
          fatVenda.strMen003 := qryConCfo.FieldByName('CFO_MNAT03').AsString;
      end;

      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDigDadosGarantia.FormCreate(Sender: TObject);
begin
  inherited;
  strClaFis := EmptyStr;
  blnTemST := False;
  enuTipoEnvioFornecedorGarantia := tefNulo;
  strCrePgc := fTransform(fCfgSis('CREPGC'), 3);
  blnEntPedGarantia := False;
end;

procedure TfrmFatDigDadosGarantia.FormShow(Sender: TObject);
begin
  inherited;

  if strClaFis = EmptyStr then
  begin
    edtClaFis.Text := EmptyStr;
    edtDesCla.Text := EmptyStr;
  end
  else
  begin
    edtClaFis.Text := strClaFis;
    fValidaCampos(edtClaFis);
  end;

  pSetFocus(edtClaFis);

  If not blnTemST Then
  Begin
    lblSub.Visible    := blnTemST;
    edtClaSub.Visible := blnTemST;
    edtDesSub.Visible := blnTemST;

    Self.Height := Self.Height - lblSub.Height - edtClaSub.Height - 5;
  End;

  pDefinirPainelMsg;

end;

End.

