unit untFatCatalogoAlteraItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, Uni, QColorLabel, StrUtils, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Data.DB, Datasnap.DBClient, UniClientDataSet,
  untPreAlt, MemoFocus, untPreAlt_Trigger;

type
  TfrmFatCatalogoAlteraItem = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlPrecos: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    lblTitMarBr1: TLabel;
    lblTitPreVe1: TLabel;
    Label33: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    lblMarBr1: TLabel;
    lblDesMax: TLabel;
    lblDesMaxPor: TLabel;
    edtPreCom: TEditFocus;
    edtDesf01: TEditFocus;
    edtIcmEnt: TEditFocus;
    edtIpiEnt: TEditFocus;
    edtFreEnt: TEditFocus;
    edtSubsti: TEditFocus;
    edtPreCus: TEditFocus;
    edtMarBr1: TEditFocus;
    edtPreVe1: TEditFocus;
    edtDesf02: TEditFocus;
    pnlBotoesEnt: TPanel;
    btnConfirma: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    Label2: TLabel;
    edtPesIte: TEditFocus;
    Label3: TLabel;
    edtEmbala: TEditFocus;
    Label75: TLabel;
    Label77: TLabel;
    edtComVar: TEditFocus;
    Label23: TLabel;
    edtAcrFin: TEditFocus;
    Label42: TLabel;
    Label1: TLabel;
    edtCodFab: TEditFocus;
    edtDesIte: TEditFocus;
    Label5: TLabel;
    Label4: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label10: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lbl2: TLabel;
    edtClaIpi: TEditFocus;
    lbl3: TLabel;
    lbl5: TColorLabel;
    edtCprCen: TEditFocus;
    lbl6: TLabel;
    edtCodBar: TEditFocus;
    lblTitMarBr2: TLabel;
    edtMarBr2: TEditFocus;
    lblMarBr2: TLabel;
    edtPreVe2: TEditFocus;
    lblTitPreVe2: TLabel;
    lblTitMarBr3: TLabel;
    edtMarBr3: TEditFocus;
    lblMarBr3: TLabel;
    edtPreVe3: TEditFocus;
    lblTitPreVe3: TLabel;
    lblTitMarBr4: TLabel;
    edtMarBr4: TEditFocus;
    lblMarBr4: TLabel;
    edtPreVe4: TEditFocus;
    lblTitPreVe4: TLabel;
    lblTitMarBr5: TLabel;
    edtMarBr5: TEditFocus;
    lblMarBr5: TLabel;
    edtPreVe5: TEditFocus;
    lblTitPreVe5: TLabel;
    lblTitMarBr6: TLabel;
    edtMarBr6: TEditFocus;
    lblMarBr6: TLabel;
    edtPreVe6: TEditFocus;
    lblTitPreVe6: TLabel;
    lblTitMarBr7: TLabel;
    edtMarBr7: TEditFocus;
    lblMarBr7: TLabel;
    edtPreVe7: TEditFocus;
    lblTitPreVe7: TLabel;
    lbl1: TLabel;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    lbl4: TLabel;
    edtCodAbf: TEditFocus;
    edtDesAbf: TEditFocus;
    Label6: TLabel;
    edtBarEmb: TEditFocus;
    lblPesLiq: TLabel;
    edtPesLiq: TEditFocus;
    Label7: TLabel;
    edtIcmSai: TEditFocus;
    Label8: TLabel;
    cdsConsulta: TUniClientDataSet;
    Label9: TLabel;
    Label11: TLabel;
    edtDesf03: TEditFocus;
    Label12: TLabel;
    Label15: TLabel;
    edtDesf04: TEditFocus;
    Label16: TLabel;
    Label17: TLabel;
    edtDesf05: TEditFocus;
    Label18: TLabel;
    Label19: TLabel;
    edtDesf06: TEditFocus;
    Label25: TLabel;
    edtSubFed: TEditFocus;
    Label27: TLabel;
    lblDesAdi: TLabel;
    Label29: TLabel;
    edtDesAdb: TEditFocus;
    lblValFre: TLabel;
    edtValFre: TEditFocus;
    lblOutVal: TLabel;
    edtOutVal: TEditFocus;
    Label31: TLabel;
    edtImpfed: TEditFocus;
    Label32: TLabel;
    Label34: TLabel;
    edtDesOpe: TEditFocus;
    Label35: TLabel;
    Label28: TLabel;
    edtRefere: TEditFocus;
    Label36: TLabel;
    mmoAplica: TMemoFocus;
    chkPreDol: TCheckBox;
    edtDolar1: TEditFocus;
    lblDolar1: TLabel;
    edtDolar2: TEditFocus;
    lblDolar2: TLabel;
    lblDolar3: TLabel;
    edtDolar3: TEditFocus;
    edtDolar4: TEditFocus;
    lblDolar4: TLabel;
    lblDolar5: TLabel;
    edtDolar5: TEditFocus;
    lblDolar7: TLabel;
    edtDolar7: TEditFocus;
    edtDolar6: TEditFocus;
    lblDolar6: TLabel;
    pnlSuframa: TPanel;
    edtTCIFCu: TEditFocus;
    edtTSCust: TEditFocus;
    edtDePiCo: TEditFocus;
    edtDeICMS: TEditFocus;
    edtFatReg: TEditFocus;
    Label37: TLabel;
    Label38: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbfKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarBr1Exit(Sender: TObject);
    function  fTeveAlteracao: boolean;
    procedure chkPreDolClick(Sender: TObject);
  private
    { Private declarations }
    strDesValFre: String;

    qryConAbf: TUniQuery;
    qryCadUni: TUniQuery;
    strMasVal: String;
    strMasPer: String;
    intDecUni: Integer;
    Procedure pAjustaBarEmb;
    procedure pValidarPrecos(Sender: TObject);
    procedure pRecalculaPrecos;
    function fRetPrecoCusto: Double;
    function fRetPrecoVenda(intOpcao, intNumPreVen: Integer): Double;
    function fVerificaItemJaCadastrado(strCodFor, strCodFab: String): Boolean;
    procedure pAjustaDolar;


    Function fValidaMargemNegativa: Boolean;

    Function fTemMargemNegativa: Boolean;

    function fEdtFocus(strNome: String): TEditFocus;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnPreMat: Boolean;
    {*********************************************************}
    {* VARIAVEL QUE INDICA SE É ALTERADO OU INCLUSAO DE ITEM *}
    {* INCLUSAO = INC E ALTERACAO = ALT                      *}
    {******************************************************LU*}
    strOpcao: String;

    {***************************************}
    {* CODIGO DO PRODUTO QUE SERA ALTERADO *}
    {************************************LU*}
    strAltCadProdItem : String;

    strCodForAlt: String;
    strCodFabAlt: String;

    procedure pCarregaItemCatalogo(strDesite,
                                   strCodFab,
                                   strCodUni,
                                   strClaIpi,
                                   strCprCen,
                                   strCodFor: String;
                                   fltPreCom,
                                   fltPreCus,
                                   fltPreVe1,
                                   fltPreVe2,
                                   fltPreVe3,
                                   fltPreVe4,
                                   fltPreVe5,
                                   fltPreVe6,
                                   fltPreVe7,
                                   fltDesf01,
                                   fltDesf02,
                                   fltDesf03,
                                   fltDesf04,
                                   fltDesf05,
                                   fltDesf06,
                                   fltIpiEnt,
                                   fltFreEnt,
                                   fltAcrFin,
                                   fltComVar,
                                   fltPesoIt,
                                   fltPesLiq,                                   
                                   fltEmbala,
                                   fltMarbr1,
                                   fltMarbr2,
                                   fltMarbr3,
                                   fltMarbr4,
                                   fltMarbr5,
                                   fltMarbr6,
                                   fltMarbr7,
                                   fltIcmEnt,
                                   fltSubFed,
                                   fltIcmSai,
                                   fltSubsti,
                                   fltDesAdb,
                                   fltValFre,
                                   fltOutVal,
                                   fltImpFed,
                                   fltDesOpe: Double;
                                   strCodAbf,
                                   strCodMar,
                                   strCodBar,
                                   strBarEmb,
                                   strRefere,
                                   strAplica: String;
                                   blnPredol: Boolean;
                                   fltTCIFCu,
                                   fltTSCust,
                                   fltDePiCo,
                                   fltDeICMS,
                                   fltFatReg: Double);
  end;

var
  frmFatCatalogoAlteraItem: TfrmFatCatalogoAlteraItem;

implementation

uses untParCalculaPrecoCusto, untFuncoesSimples, untConstantes, untTypesSistema,
  untPai,untConsultas, untIteBar, untTConfiguracao, untAltDes, untZClient,
  untProdMargemNegativa;

{$R *.dfm}

function TfrmFatCatalogoAlteraItem.fEdtFocus(strNome: String): TEditFocus;
begin
  Result := TEditFocus(Self.FindComponent(strNome));
end;

Procedure TfrmFatCatalogoAlteraItem.pAjustaBarEmb;
Begin
  If fEmptyStr(edtBarEmb.Text) Then
  Begin
    edtEmbala.Enabled := False;
    edtEmbala.Text := '0,00';
  End
  Else edtEmbala.Enabled := True;
End;

function TfrmFatCatalogoAlteraItem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomEdt: String;
Begin

  If Sender Is TEditFocus Then
    strNomEdt := UpperCase(TEditFocus(Sender).Name)
  Else
    strNomEdt := '';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodFab) Then
    Begin
      If fEmptyStr(edtCodFab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código de Fábrica deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (strOpcao = 'INC') Or (strOpcao = 'HER') Then
        Begin
          If fVerificaItemJaCadastrado(strCodForAlt, edtCodFab.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Já existe um produto com esse Código de Fábrica. Verifique!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = edtDesIte) Then
    Begin

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Produto deve ser preenchida!', ['&O k']);
        Result := False;
      End

    End
    Else If (Sender = edtCodFor) Then
    Begin

      If (fEmptyStr(edtCodFor.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtClaIpi) Then
    Begin
      If (Not fEmptyStr(edtClaIpi.Text)) And (Length(edtClaIpi.Text) <> MAX_CLAIPI) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
      End;
    End
    
    Else If (Sender = edtCprCen) Then
    Begin

      If (Pos(edtCprCen.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto com Compra Centralizada deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End

    End
    Else If (Sender = edtPreCom) Then
    Begin

      If fStrToFloat(edtPreCom.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaPrecos;

    End

    Else If (Sender = edtValFre) Then
    Begin
      If fStrToFloat(edtValFre.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "' + strDesValFre + '" deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaPrecos;
    End

    Else If (Sender = edtOutVal) Then
    Begin
      If fStrToFloat(edtOutVal.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', '" ' + lblOutVal.Caption + '" deve ser maior que Zero!', ['&OK']);
        Result := False;
      End
      Else
        pRecalculaPrecos;
    End

    Else If (Sender = edtDesf01) Then
    Begin

      If Not fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        If Not fValidaEscala((Sender As TEditFocus).Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        (Sender As TEditFocus).Text := '0,00';

    End
    Else If (Sender = edtIcmEnt) And (edtIcmEnt.Enabled) Then
    Begin

      If Not fEmptyStr(edtIcmEnt.Text) Then
      Begin
        If Not fValidaEscala(edtIcmEnt.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
        edtIcmEnt.Text := '0,00';
    End

    Else If (Sender = edtSubFed) And (edtSubFed.Enabled) Then
    Begin

      If Not fEmptyStr(edtSubFed.Text) Then
      Begin
        If Not fValidaEscala(edtSubFed.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
        edtSubFed.Text := '0,00';
    End

    Else If (Sender = edtIcmSai) And (edtIcmSai.Enabled) Then
    Begin

      If Not fEmptyStr(edtIcmSai.Text) Then
      Begin
        If Not fValidaEscala(edtIcmSai.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
        edtIcmSai.Text := '0,00';
    End

    Else If (Sender = edtImpFed) And (edtImpFed.Enabled) Then
    Begin

      If Not fEmptyStr(edtImpFed.Text) Then
      Begin
        If Not fValidaEscala(edtImpFed.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
        edtImpFed.Text := '0,00';
    End

    Else If (Sender = edtDesOpe) And (edtDesOpe.Enabled) Then
    Begin

      If Not fEmptyStr(edtDesOpe.Text) Then
      Begin
        If Not fValidaEscala(edtDesOpe.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
        edtDesOpe.Text := '0,00';
    End

    Else If (Sender = edtIpiEnt) Then
    Begin

      If Not fEmptyStr(edtIpiEnt.Text) Then
      Begin
        If Not fValidaEscala(edtIpiEnt.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O IPI de entrada deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtIpiEnt.Text := '0,00';

    End
    Else If (Sender = edtFreEnt) Then
    Begin

      If Not fEmptyStr(edtFreEnt.Text) Then
      Begin
        If Not fValidaEscala(edtFreEnt.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Frete deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtFreEnt.Text := '0,00';

    End
    Else If (Sender = edtDesf02) Then
    Begin

      If Not fEmptyStr(edtDesf02.Text) Then
      Begin
        If Not fValidaEscala(edtDesf02.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesf02.Text := '0,00';

    End

    Else If (Sender = edtDesf03) Then
    Begin

      If Not fEmptyStr(edtDesf03.Text) Then
      Begin
        If Not fValidaEscala(edtDesf03.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesf03.Text := '0,00';

    End

    Else If (Sender = edtDesf04) Then
    Begin

      If Not fEmptyStr(edtDesf04.Text) Then
      Begin
        If Not fValidaEscala(edtDesf04.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesf04.Text := '0,00';

    End

    Else If (Sender = edtDesf05) Then
    Begin

      If Not fEmptyStr(edtDesf05.Text) Then
      Begin
        If Not fValidaEscala(edtDesf05.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesf05.Text := '0,00';

    End

    Else If (Sender = edtDesf06) Then
    Begin

      If Not fEmptyStr(edtDesf06.Text) Then
      Begin
        If Not fValidaEscala(edtDesf06.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesf06.Text := '0,00';

    End

    Else If (Sender = edtAcrFin) Then
    Begin

      If Not fEmptyStr(edtAcrFin.Text) Then
      Begin
        If Not fValidaEscala(edtAcrFin.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Acrescimo final deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtAcrFin.Text := '0,00';
      End;

    End
    Else If (Sender = edtCodAbf) Then
    Begin
      edtDesAbf.Text := fRetDescricao(edtCodAbf.Text,'ABFICM','ABF_CODABF','ABF_DESABF');

      If Not (fAbrFiscalCadastrada(edtCodAbf.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Abreviação não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodUni) Then
    Begin

      edtDesUni.Text := fRetNomUnidade(edtCodUni.Text);

      If (fEmptyStr(edtCodUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (fEmptyStr(edtDesUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = edtSubsti) Then
    Begin

      If Not fEmptyStr(edtSubsti.Text) Then
      Begin
        If Not fValidaEscala(edtSubsti.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Substituição Tributária deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
        edtSubsti.Text := '0,00';

    End

    Else If (Sender = edtDesAdb) Then
    Begin

      If Not fEmptyStr(edtDesAdb.Text) Then
      Begin
        If Not fValidaEscala(edtDesAdb.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo ' + fCfgSis('DESADI') + ' deve estar entre 0 e 100!', ['&OK']);
          Result := False;
        End
      End
      Else
        edtDesAdb.Text := '0,00';

    End

    Else If (Sender = edtCodBar) Then
    Begin

      If fEmptyStr(edtCodBar.Text) Then
      Begin
        edtBarEmb.Enabled := False;
        edtBarEmb.Text    := '';
      End Else
      Begin
        edtBarEmb.Enabled := True;

        If (Not fEmptyStr(strAltCadProdItem)) And
           (Not fValidaCodBarraEsemelhante(edtCodBar.Text, strAltCadProdItem)) Then
          Result := False;

      End;

      pAjustaBarEmb;

    End

    Else If (Sender = edtTCIFCu) Then
    Begin

      If Not fEmptyStr(edtTCIFCu.Text) Then
      Begin
        If Not fValidaEscala(edtTCIFCu.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo TCIF deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
        edtTCIFCu.Text := '0,00';

    End

    Else If (Sender = edtTSCust) Then
    Begin

      If Not fEmptyStr(edtTSCust.Text) Then
      Begin
        If Not fValidaEscala(edtTSCust.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo TS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
        edtTSCust.Text := '0,00';

    End

    Else If (Sender = edtDePiCo) Then
    Begin

      If Not fEmptyStr(edtDePiCo.Text) Then
      Begin
        If Not fValidaEscala(edtDePiCo.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto PIS/COFINS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
        edtDePiCo.Text := '0,00';

    End

    Else If (Sender = edtDeICMS) Then
    Begin

      If Not fEmptyStr(edtDeICMS.Text) Then
      Begin
        If Not fValidaEscala(edtDeICMS.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto ICMS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
        edtDeICMS.Text := '0,00';

    End

    Else If (Sender = edtFatReg) Then
    Begin

      If Not fEmptyStr(edtFatReg.Text) Then
      Begin
        If Not fValidaEscala(edtFatReg.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Fator Regional deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
        edtFatReg.Text := '0,00';

    End

    Else If (Sender = edtBarEmb) Then
    Begin
      pAjustaBarEmb;

      If (Not fEmptyStr(edtBarEmb.Text)) And (Not fEmptyStr(strAltCadProdItem)) And
         (Not fValidaCodBarraEsemelhante(edtBarEmb.Text, strAltCadProdItem)) Then
        Result := False;

    End

    Else If (Sender = edtEmbala) Then
    Begin

      If (Not fEmptyStr(edtBarEmb.Text)) And (fStrToFloat(edtEmbala.Text) <= 0) Then
      Begin
        pMensagemOk('Informe a quantidade da embalagem!');
        Result := False;
      End;

    End

    Else If fEmptyStr(edtCodMar.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Marca deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
      If fEmptyStr(edtDesMar.Text) Then
      Begin
        fMensagem('AVISO','Código da Marca não encontrado.', ['&O K']);
        edtCodMar.Clear;
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender)
  Else If blnBuscaPorChave And ((Pos('EDTPREVE', strNomEdt) <= 0)) Then
    pRecalculaPrecos;

end;

procedure TfrmFatCatalogoAlteraItem.pValidarPrecos(Sender: TObject);
  Var
    Result   : Boolean;
    intTabPre: Integer;
    strNomEdt: String;
begin

  Result := True;

  strNomEdt := UpperCase(TEditFocus(Sender).Name);

  If (Sender Is TEditFocus) And
     (TEditFocus(Sender).Visible) And
     (Pos(UpperCase('EDTMARBR'), strNomEdt) > 0) Then
  Begin

    intTabPre := StrToInt(RightStr(strNomEdt, 1));

    If Not fEmptyStr(TEditFocus(Sender).Text) Then
    Begin
      If fStrToFloat(TEditFocus(Sender).Text) > MAX_VALMON Then
      Begin
        TEditFocus(Sender).Text := FloatToStr(MAX_VALMON);
      End;

      {*******************************************}
      {* CASO SEJA MARGEM                        *}
      {****************************************JB*}
      If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
      Begin
        If (fStrToFloat(TEditFocus(Sender).Text) >= 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
          Result := False;
        End;

      End;
    End;

    If Result Then
      (Self.FindComponent('edtPreVe' + IntToStr(intTabPre)) As TEditFocus).Text := FormatFloat(strMasVal, fRetPrecoVenda(1, intTabPre));

  End
  Else If (Sender is TEditFocus) And
          (TEditFocus(Sender).Visible) And
          (Pos('EDTPREVE', strNomEdt) > 0) Then
  Begin
    intTabPre := StrToInt(RightStr(strNomEdt, 1));
    (Self.FindComponent('edtMarBr' + IntToStr(intTabPre)) As TEditFocus).Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), fRetPrecoVenda(2, intTabPre));
  End;

  If (Not Result) And (TEditFocus(Sender).CanFocus) Then
  Begin
    pSetFocus(TEditFocus(Sender));
  End
  Else If Pos(Copy(strNomEdt, 1, Length(strNomEdt) - 1), 'EDTPREVE_EDTMARBR_') <= 0 Then
  Begin
    pRecalculaPrecos;
  End;

end;

procedure TfrmFatCatalogoAlteraItem.pRecalculaPrecos;
  Var
    intTabPre: Integer;
begin
  If fPreMat Then Exit;


  edtPreCus.Text := FloatToStrF(fRetPrecoCusto, ffNumber, 12, fCfgSis('DECUNI', varInteger));

  For intTabPre := 1 To Length(VS_strTabVen) Do
    (Self.FindComponent('edtPreVe' + IntToStr(intTabPre)) As TEditFocus).Text := FormatFloat(strMasVal, fRetPrecoVenda(1, intTabPre));

  pAjustaDolar;
end;

procedure TfrmFatCatalogoAlteraItem.pCarregaItemCatalogo(strDesite,
                                                         strCodFab,
                                                         strCodUni,
                                                         strClaIpi,
                                                         strCprCen,
                                                         strCodFor: String;
                                                         fltPreCom,
                                                         fltPreCus,
                                                         fltPreVe1,
                                                         fltPreVe2,
                                                         fltPreVe3,
                                                         fltPreVe4,
                                                         fltPreVe5,
                                                         fltPreVe6,
                                                         fltPreVe7,
                                                         fltDesf01,
                                                         fltDesf02,
                                                         fltDesf03,
                                                         fltDesf04,
                                                         fltDesf05,
                                                         fltDesf06,
                                                         fltIpiEnt,
                                                         fltFreEnt,
                                                         fltAcrFin,
                                                         fltComVar,
                                                         fltPesoIt,
                                                         fltPesLiq,
                                                         fltEmbala,
                                                         fltMarbr1,
                                                         fltMarbr2,
                                                         fltMarbr3,
                                                         fltMarbr4,
                                                         fltMarbr5,
                                                         fltMarbr6,
                                                         fltMarbr7,
                                                         fltIcmEnt,
                                                         fltSubFed,
                                                         fltIcmSai,
                                                         fltSubsti,
                                                         fltDesAdb,
                                                         fltValFre,
                                                         fltOutVal,
                                                         fltImpFed,
                                                         fltDesOpe: Double;
                                                         strCodAbf,
                                                         strCodMar,
                                                         strCodBar,
                                                         strBarEmb,
                                                         strRefere,
                                                         strAplica: String;
                                                         blnPredol: Boolean;
                                                         fltTCIFCu,
                                                         fltTSCust,
                                                         fltDePiCo,
                                                         fltDeICMS,
                                                         fltFatReg: Double);
Begin
  strCodForAlt   := strCodFor;
  strCodFabAlt   := strCodFab;

  edtCodFab.Text := strCodFab;
  edtDesIte.Text := strDesite;
  edtCodFor.Text := strCodFor;
  edtCodForExit(nil);
  edtCodMar.Text := strCodMar;
  edtCodBar.Text := strCodBar;
  edtBarEmb.Text := strBarEmb;

  edtRefere.Text := strRefere;
  mmoAplica.Text := strAplica;

  edtCodUni.Text := strCodUni;
  edtClaIpi.Text := strClaIpi;
  edtCprCen.Text := strCprCen;

  edtPreCom.Text := FormatFloat(strMasVal,fltPreCom); //FormatFloat('#,###0.00',fltPreCom);
  edtPreVe1.Text := FormatFloat(strMasVal,fltPreVe1);
  edtPreVe2.Text := FormatFloat(strMasVal,fltPreVe2);
  edtPreVe3.Text := FormatFloat(strMasVal,fltPreVe3);
  edtPreVe4.Text := FormatFloat(strMasVal,fltPreVe4);
  edtPreVe5.Text := FormatFloat(strMasVal,fltPreVe5);
  edtPreVe6.Text := FormatFloat(strMasVal,fltPreVe6);
  edtPreVe7.Text := FormatFloat(strMasVal,fltPreVe7);
  edtDesf01.Text := FormatFloat(strMasPer,fltDesf01);
  edtDesf02.Text := FormatFloat(strMasPer,fltDesf02);
  edtDesf03.Text := FormatFloat(strMasPer,fltDesf03);
  edtDesf04.Text := FormatFloat(strMasPer,fltDesf04);
  edtDesf05.Text := FormatFloat(strMasPer,fltDesf05);
  edtDesf06.Text := FormatFloat(strMasPer,fltDesf06);
  edtIcmEnt.Text := FormatFloat(strMasPer,fltIcmEnt);
  edtSubFed.Text := FormatFloat(strMasPer,fltSubFed);
  edtIcmSai.Text := FormatFloat(strMasPer,fltIcmSai);
  edtImpFed.Text := FormatFloat(strMasPer,fltImpFed);
  edtDesOpe.Text := FormatFloat(strMasPer,fltDesOpe);
  edtIpiEnt.Text := FormatFloat(strMasPer,fltIpiEnt); // FormatFloat('#,###0.00',((fltIpiEnt - 1) * 100));
  edtFreEnt.Text := FormatFloat(strMasPer,fltFreEnt); // FormatFloat('#,###0.00',((fltFreEnt - 1) * 100));
  edtAcrFin.Text := FormatFloat(strMasPer,fltAcrFin); // FormatFloat('#,###0.00',((fltAcrFin - 1) * 100));
  edtComVar.Text := FormatFloat(strMasPer,fltComVar);
  edtPreCus.Text := FormatFloat(strMasVal,fltPreCus);
  edtMarBr1.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr1);
  edtMarBr2.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr2);
  edtMarBr3.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr3);
  edtMarBr4.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr4);
  edtMarBr5.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr5);
  edtMarBr6.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr6);
  edtMarBr7.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),fltMarbr7);
  edtPesIte.Text := FormatFloat(strMasVal,fltPesoIt);
  edtPesLiq.Text := FormatFloat(strMasVal,fltPesLiq);
  edtEmbala.Text := FormatFloat(strMasVal,fltEmbala);
  edtSubsti.Text := FormatFloat(strMasPer,fltSubsti);
  edtDesAdb.Text := FormatFloat(strMasPer,fltDesAdb);
  edtValFre.Text := FormatFloat(strMasVal,fltValFre);
  edtOutVal.Text := FormatFloat(fMskDigitos(3),fltOutVal);
  edtTCIFCu.Text := FormatFloat(strMasPer,fltTCIFCu);
  edtTSCust.Text := FormatFloat(strMasPer,fltTSCust);
  edtDePiCo.Text := FormatFloat(strMasPer,fltDePiCo);
  edtDeICMS.Text := FormatFloat(strMasPer,fltDeICMS);
  edtFatReg.Text := FormatFloat(strMasPer,fltFatReg);

  edtCodAbf.Text := strCodAbf;
  chkPreDol.Checked := blnPredol;
End;

procedure TfrmFatCatalogoAlteraItem.FormShow(Sender: TObject);
  Var
    intTabPre: Integer;
begin
  inherited;

  If Not fEmptyStr(edtCodabf.Text) Then
    fValidaCampos(edtCodabf);
  If Not fEmptyStr(edtCodMar.Text) Then
    fValidaCampos(edtCodMar);

  If Pos(fCfgSis('MARMKP'), '1_5_') = 0 Then
  Begin
    For intTabPre := 1 To Length(VS_strTabVen) Do
      If Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre)) <> Nil Then
        TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre))).Caption := 'Markup 0' + IntToStr(intTabPre) + ':';
  End;

  pnlPrecos.Enabled := Not blnPreMat;

  edtPreCom.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe1.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe2.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe3.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe4.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe5.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe6.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreVe7.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtDesf01.EditFormat := strMasPer;
  edtDesf02.EditFormat := strMasPer;
  edtDesf03.EditFormat := strMasPer;
  edtDesf04.EditFormat := strMasPer;
  edtDesf05.EditFormat := strMasPer;
  edtDesf06.EditFormat := strMasPer;
  edtIpiEnt.EditFormat := strMasPer;
  edtFreEnt.EditFormat := strMasPer;
  edtIcmEnt.EditFormat := strMasPer;
  edtSubFed.EditFormat := strMasPer;
  edtIcmSai.EditFormat := strMasPer;
  edtImpFed.EditFormat := strMasPer;
  edtDesOpe.EditFormat := strMasPer;
  edtAcrFin.EditFormat := strMasPer;
  edtComVar.EditFormat := strMasPer;
  edtPreCus.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtMarBr1.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr2.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr3.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr4.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr5.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr6.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr7.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtPesIte.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPesLiq.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));  
  edtEmbala.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtSubsti.EditFormat := strMasPer;
  edtDesAdb.EditFormat := strMasPer;
  edtValFre.EditFormat := fMskDigitos(2);
  edtOutVal.EditFormat := fMskDigitos(3);
  edtTCIFCu.EditFormat := strMasPer;
  edtTSCust.EditFormat := strMasPer;
  edtDePiCo.EditFormat := strMasPer;
  edtDeICMS.EditFormat := strMasPer;
  edtFatReg.EditFormat := strMasPer;

  If (strOpcao = 'ALT') Or (strOpcao = 'HER') Then
  Begin
    pSetFocus(edtCodFab);
  End
  Else
  Begin
    edtDesIte.Clear;
    edtCodFab.Clear;
    edtCodFor.Clear;
    edtNomFor.Clear;
    edtCodMar.Clear;
    edtDesMar.Clear;
    edtCodUni.Clear;
    edtClaIpi.Clear;
    edtCprCen.Clear;
    edtCodBar.Clear;
    edtBarEmb.Clear;

    edtPreCom.Text := FormatFloat(strMasVal,0);
    edtPreVe1.Text := FormatFloat(strMasVal,0);
    edtPreVe2.Text := FormatFloat(strMasVal,0);
    edtPreVe3.Text := FormatFloat(strMasVal,0);
    edtPreVe4.Text := FormatFloat(strMasVal,0);
    edtPreVe5.Text := FormatFloat(strMasVal,0);
    edtPreVe6.Text := FormatFloat(strMasVal,0);
    edtPreVe7.Text := FormatFloat(strMasVal,0);
    edtDesf01.Text := FormatFloat(strMasPer,0);
    edtDesf02.Text := FormatFloat(strMasPer,0);
    edtDesf03.Text := FormatFloat(strMasPer,0);
    edtDesf04.Text := FormatFloat(strMasPer,0);
    edtDesf05.Text := FormatFloat(strMasPer,0);
    edtDesf06.Text := FormatFloat(strMasPer,0);
    edtIpiEnt.Text := FormatFloat(strMasPer,0);
    edtFreEnt.Text := FormatFloat(strMasPer,0);
    edtIcmEnt.Text := FormatFloat(strMasPer,0);
    edtSubFed.Text := FormatFloat(strMasPer,0);
    edtIcmSai.Text := FormatFloat(strMasPer,0);
    edtImpFed.Text := FormatFloat(strMasPer,0);
    edtDesOpe.Text := FormatFloat(strMasPer,0);

    edtAcrFin.Text := FormatFloat(strMasPer,0);
    edtComVar.Text := FormatFloat(strMasPer,0);
    edtPreCus.Text := FormatFloat(strMasVal,0);
    edtMarBr1.Text := FormatFloat(strMasPer,0);
    edtMarBr2.Text := FormatFloat(strMasPer,0);
    edtMarBr3.Text := FormatFloat(strMasPer,0);
    edtMarBr4.Text := FormatFloat(strMasPer,0);
    edtMarBr5.Text := FormatFloat(strMasPer,0);
    edtMarBr6.Text := FormatFloat(strMasPer,0);
    edtMarBr7.Text := FormatFloat(strMasPer,0);
    edtPesIte.Text := FormatFloat(strMasVal,0);
    edtEmbala.Text := FormatFloat(strMasVal,0);
    edtSubsti.Text := FormatFloat(strMasPer,0);
    edtDesAdb.Text := FormatFloat(strMasPer,0);
    edtValFre.Text := FormatFloat(fMskDigitos(2), 0);
    edtOutVal.Text := FormatFloat(fMskDigitos(3), 0);
    edtTCIFCu.Text := FormatFloat(strMasPer,0);
    edtTSCust.Text := FormatFloat(strMasPer,0);
    edtDePiCo.Text := FormatFloat(strMasPer,0);
    edtDeICMS.Text := FormatFloat(strMasPer,0);
    edtFatReg.Text := FormatFloat(strMasPer,0);

    edtCodFab.Enabled  := True;
    edtCodFab.ReadOnly := False;
    edtCodFab.Color    := clWhite;
    pSetFocus(edtCodFab);

    edtCodAbf.Clear;
  End;

  If fCfgSis('PESLIQ') <> 'SOMA' Then
  Begin
    lblPesLiq.Visible := False;
    edtPesLiq.Visible := False;
  End;

  For intTabPre := 1 To Length(VS_strTabVen) Do
  Begin
    If VS_strTabVen[intTabPre] = 'S' Then
    Begin
      TEditFocus(Self.FindComponent('edtPreVe'    + IntToStr(intTabPre))).Visible := True;
      TEditFocus(Self.FindComponent('edtMarBr'    + IntToStr(intTabPre))).Visible := True;
      TLabel    (Self.FindComponent('lblTitPreVe' + IntToStr(intTabPre))).Visible := True;
      TLabel    (Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre))).Visible := True;
      TLabel    (Self.FindComponent('lblMarBr'    + IntToStr(intTabPre))).Visible := True;
    End;
  End;

  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    pnlSuframa.Visible := True;
  end
  else
  begin
    pnlSuframa.Visible := False;
  end;

end;

procedure TfrmFatCatalogoAlteraItem.btnCancelarEntradaClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatCatalogoAlteraItem.fRetPrecoCusto: Double;
 Var
    cpcParams: TParCalculaPrecoCusto;
    blnUtilizarConversorDeMoedas: Boolean;

begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      curPreCom := fStrToFloat(edtPreCom.Text);
      curDesF01 := fStrToFloat(edtDesf01.Text);
      curDesF02 := fStrToFloat(edtDesf02.Text);
      curDesF03 := fStrToFloat(edtDesf03.Text);
      curDesF04 := fStrToFloat(edtDesf04.Text);
      curDesF05 := fStrToFloat(edtDesf05.Text);
      curDesF06 := fStrToFloat(edtDesf06.Text);
      curIPIEnt := fStrToFloat(edtIpiEnt.Text);
      curFrete  := fStrToFloat(edtFreEnt.Text);
      curICMSEnt:= fStrToFloat(edtIcmEnt.Text);
      curSubFed := fStrToFloat(edtSubFed.Text);

      curSubsti := fStrToFloat(edtSubsti.Text);
      curAcrFin := fStrToFloat(edtAcrFin.Text);
      curDesAdb := fStrToFloat(edtDesAdb.Text);
      curValFre := fStrToFloat(edtValFre.Text);

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fStrToFloat(edtTCIFCu.Text);
        curTSCust := fStrToFloat(edtTSCust.Text);
        curDePiCo := fStrToFloat(edtDePiCo.Text);
        curDeICMS := fStrToFloat(edtDeICMS.Text);
        curFatReg := fStrToFloat(edtFatReg.Text);
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    blnUtilizarConversorDeMoedas := chkPreDol.Checked;

    Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);

  Finally
    FreeAndNil(cpcParams);
  End;
end;

function TfrmFatCatalogoAlteraItem.fRetPrecoVenda(intOpcao, intNumPreVen: Integer): Double;
  Var
    intCont: Integer;
begin

  For intCont := 1 To Length(VS_strTabVen) Do
  Begin
    If fEmptyStr(TEditFocus(Self.FindComponent('edtPreVe' + IntToStr(intCont))).Text) Then
      TEditFocus(Self.FindComponent('edtPreVe' + IntToStr(intCont))).Text := '0,00';

    If fEmptyStr(TEditFocus(Self.FindComponent('edtMarBr' + IntToStr(intCont))).Text) Then
      TEditFocus(Self.FindComponent('edtMarBr' + IntToStr(intCont))).Text := '0,00';
  End;

  If intNumPreVen In [1..Length(VS_strTabVen)] Then
  Begin

    Result := fCalculaPrecoVenda(intOpcao,
                                 fStrToFloat(edtPreCus.Text) + fStrToFloat(edtOutVal.Text),
                                 fStrToFloat(TEditFocus(Self.FindComponent('edtPreVe' + IntToStr(intNumPreVen))).Text),
                                 fStrToFloat(TEditFocus(Self.FindComponent('edtMarBr' + IntToStr(intNumPreVen))).Text),
                                 fStrToFloat(edtIcmSai.Text),
                                 fStrToFloat(edtImpfed.Text),
                                 fStrToFloat(edtDesOpe.Text),
                                 0.0);
  End
  Else
  Begin
    Result := -1;
    fMensagem('', 'fRetPrecoVenda: Escolha a Opção 1 a 7!', ['&Ok']);
  End;

end;

function TfrmFatCatalogoAlteraItem.fTeveAlteracao: boolean;
begin
  Result := (cdsConsulta.FieldByName('CAT_DESITE').AsString <> edtDesIte.Text)Or
            (cdsConsulta.FieldByName('CAT_CODFAB').AsString <> strCodFabAlt) Or
            (cdsConsulta.FieldByName('CAT_CODFOR').AsString <> edtCodFor.Text) Or
            (cdsConsulta.FieldByName('CAT_PRECOM').AsFloat <> fStrToFloat(edtPreCom.Text)) Or
            (cdsConsulta.FieldByName('CAT_PRECUS').AsFloat <> fStrToFloat(edtPreCus.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE1').AsFloat <> fStrToFloat(edtPreVe1.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE2').AsFloat <> fStrToFloat(edtPreVe2.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE3').AsFloat <> fStrToFloat(edtPreVe3.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE4').AsFloat <> fStrToFloat(edtPreVe4.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE5').AsFloat <> fStrToFloat(edtPreVe5.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE6').AsFloat <> fStrToFloat(edtPreVe6.Text)) Or
            (cdsConsulta.FieldByName('CAT_PREVE7').AsFloat <> fStrToFloat(edtPreVe7.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESF01').AsFloat <> fStrToFloat(edtDesf01.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESF02').AsFloat <> fStrToFloat(edtDesf02.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESF03').AsFloat <> fStrToFloat(edtDesf03.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESF04').AsFloat <> fStrToFloat(edtDesf04.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESF05').AsFloat <> fStrToFloat(edtDesf05.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESF06').AsFloat <> fStrToFloat(edtDesf06.Text)) Or
            (cdsConsulta.FieldByName('CAT_IPIENT').AsFloat <> fStrToFloat(edtIpiEnt.Text)) Or
            (cdsConsulta.FieldByName('CAT_FREENT').AsFloat <> fStrToFloat(edtFreEnt.Text)) Or
            (cdsConsulta.FieldByName('CAT_ACRFIN').AsFloat <> fStrToFloat(edtAcrFin.Text)) Or
            (cdsConsulta.FieldByName('CAT_COMVAR').AsFloat <> fStrToFloat(edtComVar.Text)) Or
            (cdsConsulta.FieldByName('CAT_PESOIT').AsFloat <> fStrToFloat(edtPesIte.Text)) Or
            (cdsConsulta.FieldByName('CAT_EMBALA').AsFloat <> fStrToFloat(edtEmbala.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR1').AsFloat <> fStrToFloat(edtMarBr1.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR2').AsFloat <> fStrToFloat(edtMarBr2.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR3').AsFloat <> fStrToFloat(edtMarBr3.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR4').AsFloat <> fStrToFloat(edtMarBr4.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR5').AsFloat <> fStrToFloat(edtMarBr5.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR6').AsFloat <> fStrToFloat(edtMarBr6.Text)) Or
            (cdsConsulta.FieldByName('CAT_MARBR7').AsFloat <> fStrToFloat(edtMarBr7.Text)) Or
            (cdsConsulta.FieldByName('CAT_ICMENT').AsFloat <> fStrToFloat(edtIcmEnt.Text)) Or
            (cdsConsulta.FieldByName('CAT_SUBFED').AsFloat <> fStrToFloat(edtSubFed.Text)) Or
            (cdsConsulta.FieldByName('CAT_SUBSTI').AsFloat <> fStrToFloat(edtSubsti.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESADB').AsFloat <> fStrToFloat(edtDesAdb.Text)) Or
            (cdsConsulta.FieldByName('CAT_VALFRE').AsFloat <> fStrToFloat(edtValFre.Text)) Or
            (cdsConsulta.FieldByName('CAT_OUTVAL').AsFloat <> fStrToFloat(edtOutVal.Text)) Or
            (cdsConsulta.FieldByName('CAT_CODUNI').AsString <> edtCodUni.Text) Or
            (cdsConsulta.FieldByName('CAT_CLAIPI').AsString <> edtClaIpi.Text) Or
            (cdsConsulta.FieldByName('CAT_CPRCEN').AsString <> edtCprCen.Text) Or
            (cdsConsulta.FieldByName('CAT_CODABF').AsString <> edtCodAbf.Text) Or
            (cdsConsulta.FieldByName('CAT_REFERE').AsString <> edtRefere.Text) Or
            (cdsConsulta.FieldByName('CAT_APLICA').AsString <> mmoAplica.Text) Or
            (cdsConsulta.FieldByName('CAT_CODMAR').AsString <> edtCodMar.Text) Or
            (cdsConsulta.FieldByName('CAT_CODBAR').AsString <> edtCodBar.Text) Or
            (cdsConsulta.FieldByName('CAT_PESLIQ').AsFloat <> fStrToFloat(edtPesLiq.Text)) Or
            (cdsConsulta.FieldByName('CAT_ICMSAI').AsFloat <> fStrToFloat(edtIcmSai.Text)) Or
            (cdsConsulta.FieldByName('CAT_IMPFED').AsFloat <> fStrToFloat(edtImpFed.Text)) Or
            (cdsConsulta.FieldByName('CAT_DESOPE').AsFloat <> fStrToFloat(edtDesOpe.Text)) Or
            (cdsConsulta.FieldByName('CAT_TCIFCU').AsFloat <> fStrToFloat(edtTCIFCu.Text)) Or
            (cdsConsulta.FieldByName('CAT_TSCUST').AsFloat <> fStrToFloat(edtTSCust.Text)) Or
            (cdsConsulta.FieldByName('CAT_DEPICO').AsFloat <> fStrToFloat(edtDePiCo.Text)) Or
            (cdsConsulta.FieldByName('CAT_DEICMS').AsFloat <> fStrToFloat(edtDeICMS.Text)) Or
            (cdsConsulta.FieldByName('CAT_FATREG').AsFloat <> fStrToFloat(edtFatReg.Text)) Or
            (cdsConsulta.FieldByName('CAT_BAREMB').AsString <> edtBarEmb.Text);

end;

procedure TfrmFatCatalogoAlteraItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConAbf);
  FreeAndNil(qryCadUni);
end;

procedure TfrmFatCatalogoAlteraItem.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodAbf.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  chkPreDol.Checked := False;
  intDecUni := fCfgSis('DECUNI', varInteger);

  chkPreDol.Visible := fCfgSis('COTDOR', varBoolean);
  qryConAbf := fCriaQuery(Self);
  qryCadUni := fCriaQuery(Self);
  strMasVal := fMskDigitos(fCfgSis('DECUNI', varInteger));
  strMasPer := '##0.00';
  lblOutVal.Caption := fCfgSis('DOVCPP') + ' (+):';
  lblDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';

  strDesValFre := fCfgSis('DESVFR');
  lblValFre.Caption := strDesValFre + ' (+):';
end;

procedure TfrmFatCatalogoAlteraItem.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;
end;

Function TfrmFatCatalogoAlteraItem.fTemMargemNegativa: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 1 To Length(VS_strTabVen) Do
    If (VS_strTabVen[intContador] = 'S') And (fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intContador)).Text) < 0) Then
    Begin
      Result := True;
      Exit;
    End;

End;

Function TfrmFatCatalogoAlteraItem.fValidaMargemNegativa: Boolean;
  Var
    cdsItem: TZClient;
    intNumPreVen: Integer;
Begin
  Result := True;

  If Not fCfgSis('MARNEG', varBoolean) Then
    Exit;

  If fEmptyStr(strAltCadProdItem) Then
    Exit;

  If Not fTemMargemNegativa Then
    Exit;

  cdsItem := TProdMargemNegativa.fCriaDadosItem(strAltCadProdItem);

  With cdsItem Do
  If Not IsEmpty Then
  Begin
    Edit;

    FieldByName('ITE_PRECUS').AsFloat := fStrToFloat(edtPreCus.Text);

    For intNumPreVen := 1 To 7 Do
    Begin
      FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat := fStrToFloat(fEdtFocus('edtPreVe' + IntToStr(intNumPreVen)).Text);
      FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat := fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intNumPreVen)).Text);
    End;

    Post;

    Result := TProdMargemNegativa.fLiberaMargemNegativa(cdsItem, cdsItem, rotCadProdutos);
  End;

  FreeAndNil(cdsItem);
End;

procedure TfrmFatCatalogoAlteraItem.btnConfirmaClick(Sender: TObject);
  Var
    qryGen : TUniQuery;
    qryEmp : TUniQuery;
    strSQL : String;
    strSQLCadIte : String;
    strSQLIteGer : String;
    objIteBar: TIteBar;
    blnGrvLog: Boolean;
    blnBloIte : Boolean;
    strAgrupadorPreAlt: String;
begin
  inherited;

  If (strOpcao = 'ALT') And (Not fTeveAlteracao) Then
  Begin
    Close;
    Exit;
  End;

  blnBloIte := False;

  If (fCfgSis('TIPABF', varString) = '1') And (fCfgSis('CLPVDI', varBoolean)) And (strOpcao = 'ALT') And (Not fEmptyStr(strAltCadProdItem)) And
     ((strOpcao = 'ALT') And (cdsConsulta.FieldByName('CAT_CODABF').AsString <> edtCodAbf.Text)) Then
  Begin
    If fMensagem('', MSG_ALTERACAO_PRECO_VENDA_DINAMICA, ['&Sim', '&Não'], 1) = 2 Then
      Exit;

    blnBloIte := True;
  End;

  pPreAltDefineVariaveisAltPre(fNow, 'CATALOGO DE PREÇOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

  qryGen := fCriaQuery(Self);
  qryEmp := fCriaQuery(Self);
  Try
    If fVerificaCampos Then
    Begin
      Try
        blnGrvLog := False;

        If Not fValidaMargemNegativa Then
          Exit;

        fStartTransaction;

        If strOpcao = 'ALT' Then
        Begin
          strSQL := '';
          strSQL := strSQL + ' UPDATE ';
          strSQL := strSQL + '   CATITE ';
          strSQL := strSQL + ' SET ';
          strSQL := strSQL + '   CAT_CODFOR = :CODFO1, ';
          strSQL := strSQL + '   CAT_CODFAB = :CODFA1, ';
          strSQL := strSQL + '   CAT_CODMAR = :CODMAR, ';
          strSQL := strSQL + '   CAT_REFERE = :REFERE, ';
          strSQL := strSQL + '   CAT_APLICA = :APLICA, ';
          strSQL := strSQL + '   CAT_CODBAR = :CODBAR, ';
          strSQL := strSQL + '   CAT_DESITE = :DESITE, ';
          strSQL := strSQL + '   CAT_DESF01 = :DESF01, ';
          strSQL := strSQL + '   CAT_DESF02 = :DESF02, ';
          strSQL := strSQL + '   CAT_DESF03 = :DESF03, ';
          strSQL := strSQL + '   CAT_DESF04 = :DESF04, ';
          strSQL := strSQL + '   CAT_DESF05 = :DESF05, ';
          strSQL := strSQL + '   CAT_DESF06 = :DESF06, ';
          strSQL := strSQL + '   CAT_PRECOM = :PRECOM, ';
          strSQL := strSQL + '   CAT_PRECUS = :PRECUS, ';
          strSQL := strSQL + '   CAT_PREVE1 = :PREVE1, ';
          strSQL := strSQL + '   CAT_PREVE2 = :PREVE2, ';
          strSQL := strSQL + '   CAT_PREVE3 = :PREVE3, ';
          strSQL := strSQL + '   CAT_PREVE4 = :PREVE4, ';
          strSQL := strSQL + '   CAT_PREVE5 = :PREVE5, ';
          strSQL := strSQL + '   CAT_PREVE6 = :PREVE6, ';
          strSQL := strSQL + '   CAT_PREVE7 = :PREVE7, ';
          strSQL := strSQL + '   CAT_IPIENT = :IPIENT, ';
          strSQL := strSQL + '   CAT_FREENT = :FREENT, ';
          strSQL := strSQL + '   CAT_ACRFIN = :ACRFIN, ';
          strSQL := strSQL + '   CAT_COMVAR = :COMVAR, ';
          strSQL := strSQL + '   CAT_PESOIT = :PESOIT, ';
          strSQL := strSQL + '   CAT_PESLIQ = :PESLIQ, ';
          strSQL := strSQL + '   CAT_EMBALA = :EMBALA, ';
          strSQL := strSQL + '   CAT_CODUNI = :CODUNI, ';
          strSQL := strSQL + '   CAT_CLAIPI = :CLAIPI, ';
          strSQL := strSQL + '   CAT_CPRCEN = :CPRCEN, ';
          strSQL := strSQL + '   CAT_ICMENT = :ICMENT, ';
          strSQL := strSQL + '   CAT_SUBFED = :SUBFED, ';
          strSQL := strSQL + '   CAT_ICMSAI = :ICMSAI, ';
          strSQL := strSQL + '   CAT_IMPFED = :IMPFED, ';
          strSQL := strSQL + '   CAT_DESOPE = :DESOPE, ';
          strSQL := strSQL + '   CAT_SUBSTI = :SUBSTI, ';
          strSQL := strSQL + '   CAT_DESADB = :DESADB, ';
          strSQL := strSQL + '   CAT_VALFRE = :VALFRE, ';
          strSQL := strSQL + '   CAT_OUTVAL = :OUTVAL, ';
          strSQL := strSQL + '   CAT_MARBR1 = :MARBR1, ';
          strSQL := strSQL + '   CAT_MARBR2 = :MARBR2, ';
          strSQL := strSQL + '   CAT_MARBR3 = :MARBR3, ';
          strSQL := strSQL + '   CAT_MARBR4 = :MARBR4, ';
          strSQL := strSQL + '   CAT_MARBR5 = :MARBR5, ';
          strSQL := strSQL + '   CAT_MARBR6 = :MARBR6, ';
          strSQL := strSQL + '   CAT_MARBR7 = :MARBR7, ';
          strSQL := strSQL + '   CAT_ITEALT = :ITEALT, ';
          strSQL := strSQL + '   CAT_CODABF = :CODABF, ';
          strSQL := strSQL + '   CAT_DTAALT = :DTAALT, ';
          strSQL := strSQL + '   CAT_HORALT = :HORALT, ';
          strSQL := strSQL + '   CAT_OPEALT = :OPEALT, ';
          strSQL := strSQL + '   CAT_PREDOL = :PREDOL, ';
          strSQL := strSQL + '   CAT_TCIFCU = :TCIFCU, ';
          strSQL := strSQL + '   CAT_TSCUST = :TSCUST, ';
          strSQL := strSQL + '   CAT_DEPICO = :DEPICO, ';
          strSQL := strSQL + '   CAT_DEICMS = :DEICMS, ';
          strSQL := strSQL + '   CAT_FATREG = :FATREG, ';

          strSQL := strSQL + '   CAT_BAREMB = :BAREMB  ';
          strSQL := strSQL + ' WHERE ';
          strSQL := strSQL + '   CAT_CODFOR = :CODFOR AND ';
          strSQL := strSQL + '   CAT_CODFAB = :CODFAB ';

          strSQLCadIte := '';
          strSQLCadIte := strSQLCadIte + ' UPDATE ';
          strSQLCadIte := strSQLCadIte + '   CADITE ';
          strSQLCadIte := strSQLCadIte + ' SET ';
          strSQLCadIte := strSQLCadIte + '   ITE_DTAALT = :HULALT, ';
          strSQLCadIte := strSQLCadIte + '   ITE_DTAALT = :DTAALT, ';
          strSQLCadIte := strSQLCadIte + '   ITE_DESITE = :DESITE, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODFAB = :CODFA1, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODMAR = :CODMAR, ';
          strSQLCadIte := strSQLCadIte + '   ITE_REFERE = :REFERE, ';
          strSQLCadIte := strSQLCadIte + '   ITE_APLICA = :APLICA, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODBAR = :CODBAR, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODFOR = :CODFO1, ';
          strSQLCadIte := strSQLCadIte + '   ITE_PESOIT = :PESOIT, ';
          strSQLCadIte := strSQLCadIte + '   ITE_PESLIQ = :PESLIQ, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODUNI = :CODUNI, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CLAIPI = :CLAIPI, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODABF = :CODABF, ';
          strSQLCadIte := strSQLCadIte + '   ITE_EMBALA = :EMBALA, ';
          strSQLCadIte := strSQLCadIte + '   ITE_BAREMB = :BAREMB, ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODOPE = :CODOPE  ';
          strSQLCadIte := strSQLCadIte + ' WHERE ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODFOR = :CODFOR AND ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODFAB = :CODFAB AND ';
          strSQLCadIte := strSQLCadIte + '   ITE_CODITE = :CODITE ';

          strSQLIteGer := fSqlUpdateItegerCatalogo;
        End
        Else
        Begin
          strSQL := '';
          strSQL := strSQL + ' INSERT INTO ';
          strSQL := strSQL + '   CATITE ( ';
          strSQL := strSQL + ' CAT_CODFOR, ';
          strSQL := strSQL + ' CAT_CODFAB, ';
          strSQL := strSQL + ' CAT_DESITE, ';
          strSQL := strSQL + ' CAT_DESF01, ';
          strSQL := strSQL + ' CAT_DESF02, ';
          strSQL := strSQL + ' CAT_DESF03, ';
          strSQL := strSQL + ' CAT_DESF04, ';
          strSQL := strSQL + ' CAT_DESF05, ';
          strSQL := strSQL + ' CAT_DESF06, ';
          strSQL := strSQL + ' CAT_PRECOM, ';
          strSQL := strSQL + ' CAT_PRECUS, ';
          strSQL := strSQL + ' CAT_PREVE1, ';
          strSQL := strSQL + ' CAT_PREVE2, ';
          strSQL := strSQL + ' CAT_PREVE3, ';
          strSQL := strSQL + ' CAT_PREVE4, ';
          strSQL := strSQL + ' CAT_PREVE5, ';
          strSQL := strSQL + ' CAT_PREVE6, ';
          strSQL := strSQL + ' CAT_PREVE7, ';
          strSQL := strSQL + ' CAT_IPIENT, ';
          strSQL := strSQL + ' CAT_FREENT, ';
          strSQL := strSQL + ' CAT_ACRFIN, ';
          strSQL := strSQL + ' CAT_COMVAR, ';
          strSQL := strSQL + ' CAT_PESOIT, ';
          strSQL := strSQL + ' CAT_PESLIQ, ';
          strSQL := strSQL + ' CAT_EMBALA, ';
          strSQL := strSQL + ' CAT_CODUNI, ';
          strSQL := strSQL + ' CAT_CLAIPI, ';
          strSQL := strSQL + ' CAT_CPRCEN, ';
          strSQL := strSQL + ' CAT_ICMENT, ';
          strSQL := strSQL + ' CAT_SUBFED, ';
          strSQL := strSQL + ' CAT_ICMSAI, ';
          strSQL := strSQL + ' CAT_IMPFED, ';
          strSQL := strSQL + ' CAT_DESOPE, ';
          strSQL := strSQL + ' CAT_SUBSTI, ';
          strSQL := strSQL + ' CAT_DESADB, ';
          strSQL := strSQL + ' CAT_VALFRE, ';
          strSQL := strSQL + ' CAT_OUTVAL, ';
          strSQL := strSQL + ' CAT_MARBR1, ';
          strSQL := strSQL + ' CAT_MARBR2, ';
          strSQL := strSQL + ' CAT_MARBR3, ';
          strSQL := strSQL + ' CAT_MARBR4, ';
          strSQL := strSQL + ' CAT_MARBR5, ';
          strSQL := strSQL + ' CAT_MARBR6, ';
          strSQL := strSQL + ' CAT_MARBR7, ';
          strSQL := strSQL + ' CAT_CODABF, ';
          strSQL := strSQL + ' CAT_DTAALT, ';
          strSQL := strSQL + ' CAT_HORALT, ';
          strSQL := strSQL + ' CAT_OPEALT, ';
          strSQL := strSQL + ' CAT_CODMAR, ';
          strSQL := strSQL + ' CAT_REFERE, ';
          strSQL := strSQL + ' CAT_APLICA, ';
          strSQL := strSQL + ' CAT_CODBAR, ';
          strSQL := strSQL + ' CAT_BAREMB, ';
          strSQL := strSQL + ' CAT_PREDOL, ';
          strSQL := strSQL + ' CAT_TCIFCU, ';
          strSQL := strSQL + ' CAT_TSCUST, ';
          strSQL := strSQL + ' CAT_DEPICO, ';
          strSQL := strSQL + ' CAT_DEICMS, ';
          strSQL := strSQL + ' CAT_FATREG, ';
          strSQL := strSQL + ' AUTOINCREM  ';
          strSQL := strSQL + ' ) VALUES (  ';
          strSQL := strSQL + ' :CODFOR, ';
          strSQL := strSQL + ' :CODFAB, ';
          strSQL := strSQL + ' :DESITE, ';
          strSQL := strSQL + ' :DESF01, ';
          strSQL := strSQL + ' :DESF02, ';
          strSQL := strSQL + ' :DESF03, ';
          strSQL := strSQL + ' :DESF04, ';
          strSQL := strSQL + ' :DESF05, ';
          strSQL := strSQL + ' :DESF06, ';
          strSQL := strSQL + ' :PRECOM, ';
          strSQL := strSQL + ' :PRECUS, ';
          strSQL := strSQL + ' :PREVE1, ';
          strSQL := strSQL + ' :PREVE2, ';
          strSQL := strSQL + ' :PREVE3, ';
          strSQL := strSQL + ' :PREVE4, ';
          strSQL := strSQL + ' :PREVE5, ';
          strSQL := strSQL + ' :PREVE6, ';
          strSQL := strSQL + ' :PREVE7, ';
          strSQL := strSQL + ' :IPIENT, ';
          strSQL := strSQL + ' :FREENT, ';
          strSQL := strSQL + ' :ACRFIN, ';
          strSQL := strSQL + ' :COMVAR, ';
          strSQL := strSQL + ' :PESOIT, ';
          strSQL := strSQL + ' :PESLIQ, ';
          strSQL := strSQL + ' :EMBALA, ';
          strSQL := strSQL + ' :CODUNI, ';
          strSQL := strSQL + ' :CLAIPI, ';
          strSQL := strSQL + ' :CPRCEN, ';
          strSQL := strSQL + ' :ICMENT, ';
          strSQL := strSQL + ' :SUBFED, ';
          strSQL := strSQL + ' :ICMSAI, ';
          strSQL := strSQL + ' :IMPFED, ';
          strSQL := strSQL + ' :DESOPE, ';
          strSQL := strSQL + ' :SUBSTI, ';
          strSQL := strSQL + ' :DESADB, ';
          strSQL := strSQL + ' :VALFRE, ';
          strSQL := strSQL + ' :OUTVAL, ';
          strSQL := strSQL + ' :MARBR1, ';
          strSQL := strSQL + ' :MARBR2, ';
          strSQL := strSQL + ' :MARBR3, ';
          strSQL := strSQL + ' :MARBR4, ';
          strSQL := strSQL + ' :MARBR5, ';
          strSQL := strSQL + ' :MARBR6, ';
          strSQL := strSQL + ' :MARBR7, ';
          strSQL := strSQL + ' :CODABF, ';
          strSQL := strSQL + ' :DTAALT, ';
          strSQL := strSQL + ' :HORALT, ';
          strSQL := strSQL + ' :OPEALT, ';
          strSQL := strSQL + ' :CODMAR, ';
          strSQL := strSQL + ' :REFERE, ';
          strSQL := strSQL + ' :APLICA, ';
          strSQL := strSQL + ' :CODBAR, ';
          strSQL := strSQL + ' :BAREMB, ';
          strSQL := strSQL + ' :PREDOL, ';
          strSQL := strSQL + ' :TCIFCU, ';
          strSQL := strSQL + ' :TSCUST, ';
          strSQL := strSQL + ' :DEPICO, ';
          strSQL := strSQL + ' :DEICMS, ';
          strSQL := strSQL + ' :FATREG, ';
          strSQL := strSQL + ' :AUTINC )';

        End;

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('DESITE').AsString := edtDesIte.Text;
          ParamByName('DESF01').AsFloat  := fStrToFloat(edtDesf01.Text);
          ParamByName('DESF02').AsFloat  := fStrToFloat(edtDesf02.Text);
          ParamByName('DESF03').AsFloat  := fStrToFloat(edtDesf03.Text);
          ParamByName('DESF04').AsFloat  := fStrToFloat(edtDesf04.Text);
          ParamByName('DESF05').AsFloat  := fStrToFloat(edtDesf05.Text);
          ParamByName('DESF06').AsFloat  := fStrToFloat(edtDesf06.Text);
          ParamByName('PRECOM').AsFloat  := fStrToFloat(edtPreCom.Text);
          ParamByName('PRECUS').AsFloat  := fStrToFloat(edtPreCus.Text);
          ParamByName('PREVE1').AsFloat  := fStrToFloat(edtPreVe1.Text);

          If edtPreVe2.Visible Then
            ParamByName('PREVE2').AsFloat  := fStrToFloat(edtPreVe2.Text)
          Else ParamByName('PREVE2').Value := Null;

          If edtPreVe3.Visible Then
            ParamByName('PREVE3').AsFloat  := fStrToFloat(edtPreVe3.Text)
          Else ParamByName('PREVE3').Value := Null;

          If edtPreVe4.Visible Then
            ParamByName('PREVE4').AsFloat  := fStrToFloat(edtPreVe4.Text)
          Else ParamByName('PREVE4').Value := Null;

          If edtPreVe5.Visible Then
            ParamByName('PREVE5').AsFloat  := fStrToFloat(edtPreVe5.Text)
          Else ParamByName('PREVE5').Value := Null;

          If edtPreVe6.Visible Then
            ParamByName('PREVE6').AsFloat  := fStrToFloat(edtPreVe6.Text)
          Else ParamByName('PREVE6').Value := Null;

          If edtPreVe7.Visible Then
            ParamByName('PREVE7').AsFloat  := fStrToFloat(edtPreVe7.Text)
          Else ParamByName('PREVE7').Value := Null;

          ParamByName('SUBSTI').AsFloat  := fStrToFloat(edtSubsti.Text);
          ParamByName('DESADB').AsFloat  := fStrToFloat(edtDesAdb.Text);
          ParamByName('VALFRE').AsFloat  := fStrToFloat(edtValFre.Text);
          ParamByName('OUTVAL').AsFloat  := fStrToFloat(edtOutVal.Text);
          ParamByName('IPIENT').AsFloat  := fStrToFloat(edtIpiEnt.Text); // 1 + (fStrToFloat(edtIpiEnt.Text)/100);
          ParamByName('FREENT').AsFloat  := fStrToFloat(edtFreEnt.Text); // 1 + (fStrToFloat(edtFreEnt.Text)/100);
          ParamByName('ICMENT').AsFloat  := fStrToFloat(edtIcmEnt.Text);
          ParamByName('SUBFED').AsFloat  := fStrToFloat(edtSubFed.Text);
          ParamByName('ICMSAI').AsFloat  := fStrToFloat(edtIcmSai.Text);
          ParamByName('IMPFED').AsFloat  := fStrToFloat(edtImpFed.Text);
          ParamByName('DESOPE').AsFloat  := fStrToFloat(edtDesOpe.Text);
          ParamByName('COMVAR').AsFloat  := fStrToFloat(edtComVar.Text);
          ParamByName('PESOIT').AsFloat  := fStrToFloat(edtPesIte.Text);
          ParamByName('PESLIQ').AsFloat  := fStrToFloat(edtPesLiq.Text);
          ParamByName('EMBALA').AsFloat  := fStrToFloat(edtEmbala.Text);
          ParamByName('MARBR1').AsFloat  := fStrToFloat(edtMarBr1.Text);
          ParamByName('TCIFCU').AsFloat  := fStrToFloat(edtTCIFCu.Text);
          ParamByName('TSCUST').AsFloat  := fStrToFloat(edtTSCust.Text);
          ParamByName('DEPICO').AsFloat  := fStrToFloat(edtDePiCo.Text);
          ParamByName('DEICMS').AsFloat  := fStrToFloat(edtDeICMS.Text);
          ParamByName('FATREG').AsFloat  := fStrToFloat(edtFatReg.Text);

          If edtMarBr2.Visible Then
            ParamByName('MARBR2').AsFloat  := fStrToFloat(edtMarBr2.Text)
          Else ParamByName('MARBR2').Value := Null;

          If edtMarBr3.Visible Then
            ParamByName('MARBR3').AsFloat  := fStrToFloat(edtMarBr3.Text)
          Else ParamByName('MARBR3').Value := Null;

          If edtMarBr4.Visible Then
            ParamByName('MARBR4').AsFloat  := fStrToFloat(edtMarBr4.Text)
          Else ParamByName('MARBR4').Value := Null;

          If edtMarBr5.Visible Then
            ParamByName('MARBR5').AsFloat  := fStrToFloat(edtMarBr5.Text)
          Else ParamByName('MARBR5').Value := Null;

          If edtMarBr6.Visible Then
            ParamByName('MARBR6').AsFloat  := fStrToFloat(edtMarBr6.Text)
          Else ParamByName('MARBR6').Value := Null;

          If edtMarBr7.Visible Then
            ParamByName('MARBR7').AsFloat  := fStrToFloat(edtMarBr7.Text)
          Else ParamByName('MARBR7').Value := Null;

          ParamByName('ACRFIN').AsFloat  := fStrToFloat(edtAcrFin.Text); // 1 + (fStrToFloat(edtAcrFin.Text)/100);
          ParamByName('DTAALT').AsDate   := VS_Date;
          ParamByName('HORALT').AsTime   := fTime();
          ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
          ParamByName('CODUNI').AsString := edtCodUni.Text;
          ParamByName('CLAIPI').AsString := edtClaIpi.Text;
          ParamByName('CPRCEN').AsString := edtCprCen.Text;
          ParamByName('CODFOR').AsString := strCodForAlt;

          If strOpcao = 'ALT' Then
          Begin
            ParamByName('CODFA1').AsString := edtCodFab.Text;
            ParamByName('CODFO1').AsString := edtCodFor.Text;
            ParamByName('CODFAB').AsString := strCodFabAlt;
            ParamByName('CODFOR').AsString := strCodForAlt;
            ParamByName('ITEALT').AsString := 'X';
            ParamByName('DTAALT').AsDate   := VS_Date;
            ParamByName('HORALT').AsTime   := fTime();
            ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
          End
          Else
          Begin
            ParamByName('CODFAB').AsString := edtCodFab.Text;
            ParamByName('AUTINC').AsString := fRetAutoIncrem('CATITE',VS_strCodEmp);
          End;
          ParamByName('CODABF').AsString := edtCodAbf.Text;
          ParamByName('CODMAR').AsString := edtCodMar.Text;
          ParamByName('REFERE').AsString := edtRefere.Text;
          ParamByName('APLICA').AsString := mmoAplica.Text;
          ParamByName('CODBAR').AsString := edtCodBar.Text;
          ParamByName('BAREMB').AsString := edtBarEmb.Text;
          ParamByName('PREDOL').AsString := IIf(chkPreDol.Checked, 'S', 'N');


          ExecSQL;
        End;

        If Not fEmptyStr(strAltCadProdItem) Then
        Begin
          {********************}
          {* ALTERANDO CADITE *}
          {*****************LU*}
          With qryGen Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQLCadIte);
            ParamByName('HULALT').AsDateTime := fNow();
            ParamByName('DTAALT').AsDate   := VS_Date;
            ParamByName('DESITE').AsString := edtDesIte.Text;
            ParamByName('PESOIT').AsFloat  := fStrToFloat(edtPesIte.Text);
            ParamByName('PESLIQ').AsFloat  := fStrToFloat(edtPesLiq.Text);
            ParamByName('EMBALA').AsFloat  := fStrToFloat(edtEmbala.Text);
            ParamByName('CODUNI').AsString := edtCodUni.Text;
            ParamByName('CLAIPI').AsString := edtClaIpi.Text;
            ParamByName('CODFO1').AsString := edtCodFor.Text;
            ParamByName('CODFA1').AsString := edtCodFab.Text;
            ParamByName('CODFOR').AsString := strCodForAlt;
            ParamByName('CODFAB').AsString := strCodFabAlt;
            ParamByName('CODITE').AsString := strAltCadProdItem;
            ParamByName('CODABF').AsString := edtCodAbf.Text;
            ParamByName('CODMAR').AsString := edtCodMar.Text;

            ParamByName('REFERE').AsString := edtRefere.Text;
            ParamByName('APLICA').AsString := mmoAplica.Text;

            ParamByName('CODBAR').AsString := edtCodBar.Text;
            ParamByName('BAREMB').AsString := edtBarEmb.Text;
            ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

            TAltDes.pSalvaLogCompara(strAltCadProdItem, strLoginUsuarioLogado, edtDesIte.Text, edtCodFab.Text, edtCodUni.Text);

            ExecSQL;

            If (blnBloIte) Then
            Begin
              pBloquearLiberarProdutoParaVendaEmTodasEmpresasQueUsamEssePreco(strAltCadProdItem, 'N');
            End;

            objIteBar := TIteBar.Create(opcOperacoes);
            Try
              objIteBar.pIncluiCodigoBarrasCatalogo(strAltCadProdItem,
                 edtCodBar.Text,
                 edtBarEmb.Text,
                 fStrToFloat(edtEmbala.Text));

              objIteBar.pSalvaDados(strAltCadProdItem);
            Finally
              FreeAndNil(objIteBar);
            End;

            fAtualizaBarFabIte(strAltCadProdItem);
          End;

          {********************}
          {* ALTERANDO ITEGER *}
          {*****************LU*}
          If Not blnPreMat Then
          Begin
            With qryGen Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQLIteGer);
              ParamByName('DESF01').AsFloat  := fStrToFloat(edtDesf01.text);
              ParamByName('DESF02').AsFloat  := fStrToFloat(edtDesf02.Text);
              ParamByName('DESF03').AsFloat  := fStrToFloat(edtDesf03.Text);
              ParamByName('DESF04').AsFloat  := fStrToFloat(edtDesf04.Text);
              ParamByName('DESF05').AsFloat  := fStrToFloat(edtDesf05.Text);
              ParamByName('DESF06').AsFloat  := fStrToFloat(edtDesf06.Text);
              ParamByName('PRECOM').AsFloat  := fStrToFloat(edtPreCom.Text);
              ParamByName('PRECUS').AsFloat  := fStrToFloat(edtPreCus.Text);
              ParamByName('PREVE1').AsFloat  := fStrToFloat(edtPreVe1.Text);

              If edtPreVe2.Visible Then
                ParamByName('PREVE2').AsFloat  := fStrToFloat(edtPreVe2.Text)
              Else ParamByName('PREVE2').Value := Null;

              If edtPreVe3.Visible Then
                ParamByName('PREVE3').AsFloat  := fStrToFloat(edtPreVe3.Text)
              Else ParamByName('PREVE3').Value := Null;

              If edtPreVe4.Visible Then
                ParamByName('PREVE4').AsFloat  := fStrToFloat(edtPreVe4.Text)
              Else ParamByName('PREVE4').Value := Null;

              If edtPreVe5.Visible Then
                ParamByName('PREVE5').AsFloat  := fStrToFloat(edtPreVe5.Text)
              Else ParamByName('PREVE5').Value := Null;

              If edtPreVe6.Visible Then
                ParamByName('PREVE6').AsFloat  := fStrToFloat(edtPreVe6.Text)
              Else ParamByName('PREVE6').Value := Null;

              If edtPreVe7.Visible Then
                ParamByName('PREVE7').AsFloat  := fStrToFloat(edtPreVe7.Text)
              Else ParamByName('PREVE7').Value := Null;

              ParamByName('SUBSTI').AsFloat  := fStrToFloat(edtSubsti.Text);
              ParamByName('DESADB').AsFloat  := fStrToFloat(edtDesAdb.Text);
              ParamByName('VALFRE').AsFloat  := fStrToFloat(edtValFre.Text);
              ParamByName('OUTVAL').AsFloat  := fStrToFloat(edtOutVal.Text);
              ParamByName('IPIENT').AsFloat  := fStrToFloat(edtIpiEnt.Text);
              ParamByName('FREENT').AsFloat  := fStrToFloat(edtFreEnt.Text);
              ParamByName('ICMENT').AsFloat  := fStrToFloat(edtIcmEnt.Text);
              ParamByName('SUBFED').AsFloat  := fStrToFloat(edtSubFed.Text);
              ParamByName('ICMSAI').AsFloat  := fStrToFloat(edtIcmSai.Text);
              ParamByName('IMPFED').AsFloat  := fStrToFloat(edtImpFed.Text);
              ParamByName('DESOPE').AsFloat  := fStrToFloat(edtDesOpe.Text);
              ParamByName('TCIFCU').AsFloat  := fStrToFloat(edtTCIFCu.Text);
              ParamByName('TSCUST').AsFloat  := fStrToFloat(edtTSCust.Text);
              ParamByName('DEPICO').AsFloat  := fStrToFloat(edtDePiCo.Text);
              ParamByName('DEICMS').AsFloat  := fStrToFloat(edtDeICMS.Text);
              ParamByName('FATREG').AsFloat  := fStrToFloat(edtFatReg.Text);

              ParamByName('COMVAR').AsFloat  := fStrToFloat(edtComVar.Text);
              ParamByName('MARBR1').AsFloat  := fStrToFloat(edtMarBr1.Text);

              If edtMarBr2.Visible Then
                ParamByName('MARBR2').AsFloat  := fStrToFloat(edtMarBr2.Text)
              Else ParamByName('MARBR2').Value := Null;

              If edtMarBr3.Visible Then
                ParamByName('MARBR3').AsFloat  := fStrToFloat(edtMarBr3.Text)
              Else ParamByName('MARBR3').Value := Null;

              If edtMarBr4.Visible Then
                ParamByName('MARBR4').AsFloat  := fStrToFloat(edtMarBr4.Text)
              Else ParamByName('MARBR4').Value := Null;

              If edtMarBr5.Visible Then
                ParamByName('MARBR5').AsFloat  := fStrToFloat(edtMarBr5.Text)
              Else ParamByName('MARBR5').Value := Null;

              If edtMarBr6.Visible Then
                ParamByName('MARBR6').AsFloat  := fStrToFloat(edtMarBr6.Text)
              Else ParamByName('MARBR6').Value := Null;

              If edtMarBr7.Visible Then
                ParamByName('MARBR7').AsFloat  := fStrToFloat(edtMarBr7.Text)
              Else ParamByName('MARBR7').Value := Null;

              ParamByName('ACRFIN').AsFloat  := fStrToFloat(edtAcrFin.Text);
              ParamByName('CODITE').AsString := strAltCadProdItem;
              ParamByName('PREALT').AsString := strAgrupadorPreAlt;
              ParamByName('CPRCEN').AsString := edtCprCen.Text;

              qryEmp.SQL.Text := 'SELECT ITE_CODEMP FROM ITEGER WHERE ITE_CODITE = :CODITE AND LOCATE(ITE_CODEMP, :CODEMP)';
              qryEmp.ParamByName('CODITE').AsString := strAltCadProdItem;
              qryEmp.ParamByName('CODEMP').AsString := fRetEmpresasUsamPrecoMatriz;
              qryEmp.Open;
              While Not qryEmp.Eof Do
              Begin
                ParamByName('CODEMP').AsString := qryEmp.FieldByName('ITE_CODEMP').AsString;
                If (Not blnGrvLog) And (Not VS_blnPreAltViaTrigger) Then
                  blnGrvLog := fGravaPreAltCat(qryGen);
                ExecSQL;

                qryEmp.Next;
              End;
            End;
          End;
        End;

        fCommit
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[TfrmFatCatalogoAlteraItem.btnConfirmaClick]');
        End;
      End;

      Close;
    End; {If fVerificaCampos Then}
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryEmp);
    strAgrupadorPreAlt := '';

  End;
end;

procedure TfrmFatCatalogoAlteraItem.chkPreDolClick(Sender: TObject);
begin
  inherited;
  If (fStrToFloat(edtPreCom.Text) <> 0) Then
    pValidarPrecos(edtPreCom);

end;

function TfrmFatCatalogoAlteraItem.fVerificaItemJaCadastrado(strCodFor, strCodFab: String): Boolean;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  Result := False;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CATITE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CAT_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '   CAT_CODFAB = :CODFAB ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODFAB').AsString := strCodFab;
      Open;
    End;

    If qryGen.FieldByName('QTD').AsInteger > 0 Then
      Result := True;

  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmFatCatalogoAlteraItem.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatCatalogoAlteraItem.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMarcas: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE MARCAS  *}
  {*************************RV*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarcas) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatCatalogoAlteraItem.edtMarBr1Exit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(TEditFocus(Sender).Text) Then
    TEditFocus(Sender).SelStart := 1;
  pValidarPrecos(Sender);
end;

procedure TfrmFatCatalogoAlteraItem.edtCodAbfKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAbf: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE ABR.FIS *}
  {*************************RV*}
  If fPesqAbrevFiscal(Self, edtCodAbf, edtDesAbf, Nil, Key, arrAbf) Then
  Begin
    If fValidaCampos(edtCodAbf, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatCatalogoAlteraItem.edtCodForExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodFor.Text) Then
    edtNomFor.Clear
  Else
  Begin
    edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

    If fEmptyStr(edtNomFor.Text) Then
    Begin
      fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
      edtCodFor.Clear;
      pSetFocus(edtCodFor);
    End;
  End;
end;

procedure TfrmFatCatalogoAlteraItem.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
var
  arrUnidades: TConsultasArray;
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  if fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, qryCadUni, Key, arrUnidades) then
  begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmFatCatalogoAlteraItem.pAjustaDolar;
  Var
    intTabPre: Integer;
    blnVisible : Boolean;
    fltDolar : Double;
Begin

  If (chkPreDol.Visible) Then
    fltDolar := fGetUltimaCotacaoDolarVenda
  Else
    fltDolar := 0;

  blnVisible := chkPreDol.Visible And (fltDolar > 0);

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Visible := blnVisible;
    TLabel(Self.FindComponent('lblDolar' + IntToStr(intTabPre))).Visible     := blnVisible;

    If blnVisible  And (VS_strTabPrc[intTabPre] = 'S') Then
      TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Text :=
        formatFloat(fMskDigitos(intDecUni), fStrToFloat(TEditFocus(Self.FindComponent('edtPreve' + IntToStr(intTabPre))).Text) / fltDolar)
    Else
    Begin
      TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Visible := False;
      TEditFocus(Self.FindComponent('lblDolar' + IntToStr(intTabPre))).Visible := False;
    End
  End;

End;


end.
