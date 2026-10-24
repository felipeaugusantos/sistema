{**********************}
{* qryConPor = CADPOR *}
{*******************JB*}
unit untRcxTrasfValoresPar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, DB, UniClientDataSet, frxClass, StrUtils, frxDBSet, BitBtnLockedIncrem,
  Datasnap.DBClient, frxExportCSVTestabilidade, untRcxTResumoDeCaixa;

type
  TfrmRcxTrasfValoresPar = class(TfrmPai)
    pnlPortador: TPanel;
    pnlTotal: TPanel;
    pnlFundo: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    edtTotalAtu: TEditFocus;
    edtTotalTra: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    cdsChqAVi: TUniClientDataSet;
    cdsChqPre: TUniClientDataSet;
    cdsCarCre: TUniClientDataSet;
    edtChqVistaAtu: TEditFocus;
    edtChqPreAtu: TEditFocus;
    edtCartaoAtu: TEditFocus;
    EdtOrdPagAtu: TEditFocus;
    Label7: TLabel;
    edtDesPortadorChv: TEditFocus;
    edtCodPorChv: TEditFocus;
    edtCodPorChp: TEditFocus;
    edtDesPortadorChp: TEditFocus;
    edtDesPortadorCrt: TEditFocus;
    edtCodPorCrt: TEditFocus;
    edtCodPorOrd: TEditFocus;
    edtDesPortadorOrd: TEditFocus;
    Label8: TLabel;
    edtChqVistaTra: TEditFocus;
    edtChqPreTra: TEditFocus;
    edtCartaoTra: TEditFocus;
    edtOrdPagTra: TEditFocus;
    lblTransf1: TLabel;
    Label10: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    lblTransf2: TLabel;
    edtChqVistaTra2: TEditFocus;
    edtChqPreTra2: TEditFocus;
    edtCartaoTra2: TEditFocus;
    edtOrdPagTra2: TEditFocus;
    edtTotalTra2: TEditFocus;
    Label9: TLabel;
    edtGruGpo: TEditFocus;
    edtDesGpo: TEditFocus;
    Label11: TLabel;
    edtCodPorFin: TEditFocus;
    edtDesPortadorFin: TEditFocus;
    edtValFinAtu: TEditFocus;
    edtValFinTra: TEditFocus;
    edtValFinTra2: TEditFocus;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtDinheiroAtu: TEditFocus;
    edtDinheiroTra: TEditFocus;
    edtCodPorGua: TEditFocus;
    edtDesPortadorGua: TEditFocus;
    edtGuaAtu: TEditFocus;
    edtGuaTra: TEditFocus;
    edtCodPorDol: TEditFocus;
    edtDesPortadorDol: TEditFocus;
    edtDolAtu: TEditFocus;
    edtDolTra: TEditFocus;
    edtCodPorEur: TEditFocus;
    edtDesPortadorEur: TEditFocus;
    edtEurAtu: TEditFocus;
    edtEurTra: TEditFocus;
    edtCodPorPes: TEditFocus;
    edtDesPortadorPes: TEditFocus;
    edtPesAtu: TEditFocus;
    edtPesTra: TEditFocus;
    edtCodPorRea: TEditFocus;
    edtDesPortadorRea: TEditFocus;
    edtReaAtu: TEditFocus;
    edtReaTra: TEditFocus;
    edtDinheiroTra2: TEditFocus;
    edtGuaTra2: TEditFocus;
    edtDolTra2: TEditFocus;
    edtEurTra2: TEditFocus;
    edtPesTra2: TEditFocus;
    edtReaTra2: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnAltSeqFec: TBitBtnLocked;
    btnSelChAvi: TBitBtnLocked;
    btnSelChPre: TBitBtnLocked;
    btnSelCartao: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtCodPorChvExit(Sender: TObject);
    procedure edtCodPorChpExit(Sender: TObject);
    procedure edtCodPorCrtExit(Sender: TObject);
    procedure edtCodPorOrdExit(Sender: TObject);
    procedure edtCodPorChvKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorChpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorCrtKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorOrdKeyPress(Sender: TObject; var Key: Char);
    procedure btnAltSeqFecClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelChAviClick(Sender: TObject);
    procedure btnSelChPreClick(Sender: TObject);
    procedure btnSelCartaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruGpoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorEnter(Sender: TObject);
    procedure edtGruGpoEnter(Sender: TObject);
    procedure edtCodPorFinExit(Sender: TObject);
    procedure edtCodPorFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorGuaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorDolKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorEurKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorPesKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorReaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorGuaExit(Sender: TObject);
    procedure edtCodPorDolExit(Sender: TObject);
    procedure edtCodPorEurExit(Sender: TObject);
    procedure edtCodPorPesExit(Sender: TObject);
    procedure edtCodPorReaExit(Sender: TObject);
  private
    qryConPor: TUniQuery;
    qryCadOpe: TUniQuery;
    qryCadGpo: TUniQuery;
    blnOpeObr: Boolean;
    strVenAnt: String;

//    procedure pCarregaPortador(edtCodPor, edtDesPortador: TEditFocus);
    procedure pEdtCodPorExit(edtCodPor, edtDesPortador: TEditFocus);
    procedure pEdtCodPorKeyPress(edtCodPor, edtDesPortador: TEditFocus; var Key: Char);
    procedure pAtualizaValDig;
    procedure pCarregaVendedor(strCodVen: String);
    procedure pCarregaValores;
    procedure pCarregaGrupoOpe(strCodGpo: String);
    Procedure pTrataMoedas(blnEnable: Boolean);
    { Private declarations }

  public
    fltValTot: Double;
    fltValDig: Double;
    fltDinhei: Double;
    fltChqVis: Double;
    fltChqPre: Double;
    fltCartao: Double;
    fltOrdPag: Double;
    fltValFin: Double;

    fltValDi2: Double;
    fltDinhe2: Double;
    fltChqVi2: Double;
    fltChqPr2: Double;
    fltCarta2: Double;
    fltOrdPa2: Double;
    fltValFi2: Double;
    strDepos : String;

    fltGuaranie : Double;
    fltDolar    : Double;
    fltEuro     : Double;
    fltPeso     : Double;
    fltReal     : Double;

    fltGuaranie2: Double;
    fltDolar2   : Double;
    fltEuro2    : Double;
    fltPeso2    : Double;
    fltReal2    : Double;

    function fValidaValorMod(fltValDig,
                             fltValAtu: Double;
                             strModalidade: String;
                             edtPor: TEditFocus;
                             blnDinheiro: Boolean = FALSE): Boolean;
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; Override;
  end;

implementation

uses untFuncoes, untfuncoesSimples, untRcxTransfDocs, untPaiOrdena, untPesqAux,
  untCadRcxx, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmRcxTrasfValoresPar.pEdtCodPorExit(edtCodPor, edtDesPortador: TEditFocus);
begin

  If Not fEmptyStr(edtCodPor.Text) Then
    edtDesPortador.Text := fRetNomPortador(edtCodPor.Text)
  Else
    edtDesPortador.Text := '';

  If fEmptyStr(edtDesPortador.Text) And (Not fEmptyStr(edtCodPor.Text))  Then
  Begin
    fMensagem('AVISO','Código do portador não encontrado.', ['&O K']);
    edtCodPor.Clear;
    pSetFocus(edtCodPor);
    Exit;
  End
  {*REQ*145940**********RP*}
  Else If Not fEmptyStr(edtCodPor.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
    pSetFocus(edtCodPor);
    Exit;
  End
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
    Begin
      fMensagem('AVISO','Usuário sem permissão de acesso ao lançamentos deste portador!', ['&O K']);
      edtCodPor.Clear;
      pSetFocus(edtCodPor);
      Exit;
    End;
  End;

end;

procedure TfrmRcxTrasfValoresPar.PEdtCodPorKeyPress(edtCodPor, edtDesPortador: TEditFocus; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    if fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, qryConPor, Key, arrSel) then    
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

end;

{*****************************************************}
{* COM A NOVA CONSULTA ESSE PROCEDURE CAIU EM DESUSO *}
{**************************************************JU*}
//procedure TfrmRcxTrasfValores.pCarregaPortador(edtCodPor, edtDesPortador: TEditFocus);


{************************************}
{* ATUALIZA VARIAVEIS E PANEL       *}
{*********************************AF*}
procedure TfrmRcxTrasfValoresPar.pAtualizaValDig;
Begin
  fltDinhei := 0;
  fltChqVis := 0;
  fltChqPre := 0;
  fltCartao := 0;
  fltOrdPag := 0;
  fltValFin := 0;
  fltValDig := 0;

  fltDinhe2 := 0;
  fltChqVi2 := 0;
  fltChqPr2 := 0;
  fltCarta2 := 0;
  fltOrdPa2 := 0;
  fltValFi2 := 0;
  fltValDi2 := 0;

  fltGuaranie  := 0;
  fltDolar     := 0;
  fltEuro      := 0;
  fltPeso      := 0;
  fltReal      := 0;

  fltGuaranie2 := 0;
  fltDolar2    := 0;
  fltEuro2     := 0;
  fltPeso2     := 0;
  fltReal2     := 0;

  If Not fEmptyStr(edtDinheiroTra.Text) Then fltDinhei := fStrToFloat(edtDinheiroTra.Text);
  If Not fEmptyStr(edtChqVistaTra.Text) Then fltChqVis := fStrToFloat(edtChqVistaTra.Text);
  If Not fEmptyStr(edtChqPreTra.Text)   Then fltChqPre := fStrToFloat(edtChqPreTra.Text);
  If Not fEmptyStr(edtCartaoTra.Text)   Then fltCartao := fStrToFloat(edtCartaoTra.Text);
  If Not fEmptyStr(edtOrdPagTra.Text)   Then fltOrdPag := fStrToFloat(edtOrdPagTra.Text);
  If Not fEmptyStr(edtValFinTra.Text)   Then fltValFin := fStrToFloat(edtValFinTra.Text);

  If Not fEmptyStr(edtGuaTra.Text) Then fltGuaranie := fStrToFloat(edtGuaTra.Text);
  If Not fEmptyStr(edtDolTra.Text) Then fltDolar    := fStrToFloat(edtDolTra.Text);
  If Not fEmptyStr(edtEurTra.Text) Then fltEuro     := fStrToFloat(edtEurTra.Text);
  If Not fEmptyStr(edtPesTra.Text) Then fltPeso     := fStrToFloat(edtPesTra.Text);
  If Not fEmptyStr(edtReaTra.Text) Then fltReal     := fStrToFloat(edtReaTra.Text);

  fltValDig := fltDinhei + fltChqVis + fltChqPre + fltCartao + fltOrdPag + fltValFin;
  edtTotalTra.Text := FloatToStrF(fltValDig,ffFixed,12,2);

  If fCfgSis('RCXTR2', varBoolean) Then
  Begin
    If Not fEmptyStr(edtDinheiroTra2.Text) Then fltDinhe2 := fStrToFloat(edtDinheiroTra2.Text);
    If Not fEmptyStr(edtChqVistaTra2.Text) Then fltChqVi2 := fStrToFloat(edtChqVistaTra2.Text);
    If Not fEmptyStr(edtChqPreTra2.Text)   Then fltChqPr2 := fStrToFloat(edtChqPreTra2.Text);
    If Not fEmptyStr(edtCartaoTra2.Text)   Then fltCarta2 := fStrToFloat(edtCartaoTra2.Text);
    If Not fEmptyStr(edtOrdPagTra2.Text)   Then fltOrdPa2 := fStrToFloat(edtOrdPagTra2.Text);
    If Not fEmptyStr(edtValFinTra2.Text)   Then fltValFi2 := fStrToFloat(edtValFinTra2.Text);

    If Not fEmptyStr(edtGuaTra2.Text) Then fltGuaranie2 := fStrToFloat(edtGuaTra2.Text);
    If Not fEmptyStr(edtDolTra2.Text) Then fltDolar2    := fStrToFloat(edtDolTra2.Text);
    If Not fEmptyStr(edtEurTra2.Text) Then fltEuro2     := fStrToFloat(edtEurTra2.Text);
    If Not fEmptyStr(edtPesTra2.Text) Then fltPeso2     := fStrToFloat(edtPesTra2.Text);
    If Not fEmptyStr(edtReaTra2.Text) Then fltReal2     := fStrToFloat(edtReaTra2.Text);

    fltValDi2 := fltDinhe2 + fltChqVi2 + fltChqPr2 + fltCarta2 + fltOrdPa2 + fltValFi2;
    edtTotalTra2.Text := FloatToStrF(fltValDi2,ffFixed,12,2);
  End;

End;

function TfrmRcxTrasfValoresPar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  blnFocus: Boolean;
begin

  Result := True;
  blnFocus := True;

  If (Sender = edtCodVendedor) Then
  Begin
    If fEmptyStr(edtCodVendedor.Text) Then
    Begin
      If blnOpeObr Then
      Begin
        fMensagem('ATENÇÃO!','Informe o código do operador!',['&O K']);
        Result := False;
      End Else
        edtDesVendedor.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaVendedor(edtCodVendedor.Text);
      If (qryCadOpe.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!','Esse operador não está cadastrado!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtGruGpo.Clear;
        edtDesGpo.Text := 'TODOS';
        edtGruGpo.Enabled := False;

        If blnBuscaPorChave Or (strVenAnt <> edtCodVendedor.Text) Then
          pCarregaValores;
      End;
    End;

    strVenAnt := edtCodVendedor.Text;
  End

  Else If (Sender = edtGruGpo) And blnBuscaPorChave And (Not blnOpeObr) Then
  Begin
    If fEmptyStr(edtGruGpo.Text) Then
    Begin
      edtDesGpo.Text := 'TODOS';
      pCarregaValores;
    End
    Else
    Begin
      pCarregaGrupoOpe(edtGruGpo.Text);
      If (qryCadGpo.IsEmpty) Then
      Begin
        fMensagem('','Esse grupo não está cadastrado!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtCodVendedor.Clear;
        edtDesVendedor.Text := 'TODOS';
        edtCodVendedor.Enabled := False;

        pCarregaValores;
      End;
    End;
  End

  {************************************}
  {* VALIDA DINHEIRO                  *}
  {*********************************AF*}
  Else If (Sender = edtDinheiroTra) Then
  Begin

    If (fEmptyStr(edtDinheiroTra.Text)) Then
    Begin
      edtDinheiroTra.Text := '0,00';
    End
    Else
    Begin
      Result := fValidaValorMod(fStrToFloat(edtDinheiroTra.Text),fStrToFloat(edtDinheiroAtu.Text), 'dinheiro', Nil, TRUE);
    End;

    If Result Then
    Begin
      pTrataMoedas(fStrToFloat(edtDinheiroTra.Text) > 0);
      pAtualizaValDig;
    End;

  End

  Else If (Sender = edtCodPorGua) Then
  Begin

    If (fEmptyStr(edtCodPorGua.Text)) Then
    Begin
      edtGuaTra.Text := '0,00';
      edtGuaTra.Enabled := FALSE;
    End

    Else edtGuaTra.Enabled := TRUE;

  End

  Else If (Sender = edtCodPorDol) Then
  Begin

    If (fEmptyStr(edtCodPorDol.Text)) Then
    Begin
      edtDolTra.Text := '0,00';
      edtDolTra.Enabled := FALSE;
    End

    Else edtDolTra.Enabled := TRUE;


  End

  Else If (Sender = edtCodPorEur) Then
  Begin

    If (fEmptyStr(edtCodPorEur.Text)) Then
    Begin
      edtEurTra.Text := '0,00';
      edtEurTra.Enabled := FALSE;
    End

    Else edtEurTra.Enabled := TRUE;


  End

  Else If (Sender = edtCodPorPes) Then
  Begin

    If (fEmptyStr(edtCodPorPes.Text)) Then
    Begin
      edtPesTra.Text := '0,00';
      edtPesTra.Enabled := FALSE;
    End

    Else edtPesTra.Enabled := TRUE;

  End

  Else If (Sender = edtCodPorRea) Then
  Begin

    If (fEmptyStr(edtCodPorRea.Text)) Then
    Begin
      edtReaTra.Text := '0,00';
      edtReaTra.Enabled := FALSE;
    End

    Else edtReaTra.Enabled := TRUE;

  End

  {************************************}
  {* VALIDA PORTADOR                  *}
  {*********************************AF*}
  //se If (Sender = edtCodPorDin) And fEmptyStr(edtCodPorDin.Text) Then edtDinheiroTra.Text := '0,00'
  Else If (Sender = edtCodPorChv) And fEmptyStr(edtCodPorChv.Text) Then edtChqVistaTra.Text := '0,00'
  Else If (Sender = edtCodPorChp) And fEmptyStr(edtCodPorChp.Text) Then edtChqPreTra.Text   := '0,00'
  Else If (Sender = edtCodPorCrt) And fEmptyStr(edtCodPorCrt.Text) Then edtCartaoTra.Text   := '0,00'
  Else If (Sender = edtCodPorOrd) And fEmptyStr(edtCodPorOrd.Text) Then edtOrdPagTra.Text   := '0,00'
  Else If (Sender = edtCodPorFin) And fEmptyStr(edtCodPorFin.Text) Then edtValFinTra.Text   := '0,00'
  Else If (Sender = edtCodPorGua) And fEmptyStr(edtCodPorGua.Text) Then edtGuaTra.Text      := '0,00'
  Else If (Sender = edtCodPorDol) And fEmptyStr(edtCodPorDol.Text) Then edtDolTra.Text      := '0,00'
  Else If (Sender = edtCodPorEur) And fEmptyStr(edtCodPorEur.Text) Then edtEurTra.Text      := '0,00'
  Else If (Sender = edtCodPorPes) And fEmptyStr(edtCodPorPes.Text) Then edtPesTra.Text      := '0,00'
  Else If (Sender = edtCodPorRea) And fEmptyStr(edtCodPorRea.Text) Then edtReaTra.Text      := '0,00'

  Else If (Sender = edtGuaTra) Then
  Begin

    If (fEmptyStr(edtGuaTra.Text)) Then
    Begin
      edtGuaTra.Text := '0,00';
    End

    Else Result := fValidaValorMod(fStrToFloat(edtGuaTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtGuaTra2.Text), 0), fStrToFloat(edtGuaAtu.Text), 'Guaranie', edtCodPorGua);

  End

  Else If (Sender = edtDolTra) Then
  Begin

    If (fEmptyStr(edtDolTra.Text)) Then
    Begin
      edtDolTra.Text := '0,00';
    End

    Else Result := fValidaValorMod(fStrToFloat(edtDolTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtDolTra2.Text), 0), fStrToFloat(edtDolAtu.Text), 'Dolar', edtCodPorDol);

  End

  Else If (Sender = edtEurTra) Then
  Begin

    If (fEmptyStr(edtEurTra.Text)) Then
    Begin
      edtEurTra.Text := '0,00';
    End

    Else Result := fValidaValorMod(fStrToFloat(edtEurTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtEurTra2.Text), 0), fStrToFloat(edtEurAtu.Text), 'Euro', edtCodPorEur);

  End

  Else If (Sender = edtPesTra) Then
  Begin

    If (fEmptyStr(edtPesTra.Text)) Then
    Begin
      edtPesTra.Text := '0,00';
    End

    Else Result := fValidaValorMod(fStrToFloat(edtPesTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtPesTra2.Text), 0), fStrToFloat(edtPesAtu.Text), 'Euro', edtCodPorPes);

  End

  Else If (Sender = edtReaTra) Then
  Begin

    If (fEmptyStr(edtReaTra.Text)) Then
    Begin
      edtReaTra.Text := '0,00';
    End

    Else Result := fValidaValorMod(fStrToFloat(edtReaTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtReaTra2.Text), 0), fStrToFloat(edtReaAtu.Text), 'Real', edtCodPorRea);

  End

  {************************************}
  {* VALIDA CHEQUE A VISTA            *}
  {*********************************AF*}
  Else If (Sender = edtChqVistaTra) Then
  Begin

    If (fEmptyStr(edtChqVistaTra.Text)) Then
      edtChqVistaTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqVistaTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtChqVistaTra2.Text), 0), fStrToFloat(edtChqVistaAtu.Text), 'cheque a vista', edtCodPorChv);

    If Result Then
      pAtualizaValDig
    Else
    Begin
      blnFocus := False;
      If btnSelChAvi.Visible Then pSetFocus(btnSelChAvi);
    End;

  End

  {************************************}
  {* VALIDA CHEQUE A PRAZO            *}
  {*********************************AF*}
  Else If (Sender = edtChqPreTra) Then
  Begin

    If (fEmptyStr(edtChqPreTra.Text)) Then
      edtChqPreTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqPreTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtChqPreTra2.Text), 0), fStrToFloat(edtChqPreAtu.Text), 'cheque - pré', edtCodPorChp);

    If Result Then
      pAtualizaValDig
    Else
    Begin
      blnFocus := False;
      If btnSelChPre.Visible Then pSetFocus(btnSelChPre);
    End;

  End

  {************************************}
  {* VALIDA CARTÃO                    *}
  {*********************************AF*}
  Else If (Sender = edtCartaoTra) Then
  Begin

    If (fEmptyStr(edtCartaoTra.Text)) Then
      edtCartaoTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtCartaoTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtCartaoTra2.Text), 0), fStrToFloat(edtCartaoAtu.Text), 'cartão', edtCodPorCrt);

    If Result Then
      pAtualizaValDig
    Else
    Begin
      blnFocus := False;
      If btnSelCartao.Visible Then pSetFocus(btnSelCartao);
    End;

  End

  {************************************}
  {* VALIDA ORDEM DE PAGTO            *}
  {*********************************AF*}
  Else If (Sender = edtOrdPagTra) Then
  Begin

    If (fEmptyStr(edtOrdPagTra.Text)) Then
      edtOrdPagTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtOrdPagTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtOrdPagTra2.Text), 0), fStrToFloat(edtOrdPagAtu.Text), 'ordem de pagamento', edtCodPorOrd);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA FINANCIAMENTO             *}
  {*********************************LA*}
  Else If (Sender = edtValFinTra) Then
  Begin

    If (fEmptyStr(edtValFinTra.Text)) Then
      edtValFinTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtValFinTra.Text) + IIf(fCfgSis('RCXTR2', varBoolean), fStrToFloat(edtValFinTra2.Text), 0), fStrToFloat(edtValFinAtu.Text), 'financiamento', edtCodPorFin);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA DINHEIRO 2                *}
  {*********************************AF*}
  Else If (Sender = edtDinheiroTra2) Then
  Begin

    If (fEmptyStr(edtDinheiroTra2.Text)) Then
      edtDinheiroTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtDinheiroTra.Text) + fStrToFloat(edtDinheiroTra2.Text),fStrToFloat(edtDinheiroAtu.Text), 'dinheiro', Nil, True);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CHEQUE A VISTA 2          *}
  {*********************************AF*}
  Else If (Sender = edtChqVistaTra2) Then
  Begin

    If (fEmptyStr(edtChqVistaTra2.Text)) Then
      edtChqVistaTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqVistaTra.Text) + fStrToFloat(edtChqVistaTra2.Text),fStrToFloat(edtChqVistaAtu.Text), 'cheque a vista', edtCodPorChv);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CHEQUE A PRAZO 2          *}
  {*********************************AF*}
  Else If (Sender = edtChqPreTra2) Then
  Begin

    If (fEmptyStr(edtChqPreTra2.Text)) Then
      edtChqPreTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqPreTra.Text) + fStrToFloat(edtChqPreTra2.Text),fStrToFloat(edtChqPreAtu.Text), 'cheque - pré', edtCodPorChp);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CARTÃO 2                  *}
  {*********************************AF*}
  Else If (Sender = edtCartaoTra2) Then
  Begin

    If (fEmptyStr(edtCartaoTra2.Text)) Then
      edtCartaoTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtCartaoTra.Text) + fStrToFloat(edtCartaoTra2.Text),fStrToFloat(edtCartaoAtu.Text), 'cartão', edtCodPorCrt);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA ORDEM DE PAGAMENTO 2      *}
  {*********************************AF*}
  Else If (Sender = edtOrdPagTra2) Then
  Begin

    If (fEmptyStr(edtOrdPagTra2.Text)) Then
      edtOrdPagTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtOrdPagTra.Text) + fStrToFloat(edtOrdPagTra2.Text),fStrToFloat(edtOrdPagAtu.Text), 'ordem de pagamento', edtCodPorOrd);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA FINANCIAMENTO 2           *}
  {*********************************LA*}
  Else If (Sender = edtValFinTra2) Then
  Begin

    If (fEmptyStr(edtValFinTra2.Text)) Then
      edtValFinTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtValFinTra.Text) + fStrToFloat(edtValFinTra2.Text),fStrToFloat(edtValFinAtu.Text), 'financiamento', edtCodPorFin);

    If Result Then pAtualizaValDig;
  End;


  If (Not Result) And blnFocus Then
  Begin
    pSetFocus(Sender);
    If (Sender Is TEditFocus) Then
      (Sender As TEditFocus).SelectAll;
  End;

end;

procedure TfrmRcxTrasfValoresPar.FormShow(Sender: TObject);
  Var
    blnAltPtf: Boolean;

  Const
    intLeftGroup = 15;
begin
  inherited;

  blnOpeObr := fCfgSis('OBROPT', VarBoolean);
  edtGruGpo.Enabled := Not blnOpeObr;

  If fCfgSis('OPTFLG', VarBoolean) Then
  Begin
    pCarregaVendedor(edtCodVendedor.Text);
    edtCodVendedor.Enabled := False;
  End;  

  pCarregaValores;

  {****************************************************}
  {* TRAZ COMO SUGESTÃO OS PORTADORES JÁ CONFIGURADOS *}
  {* EM CONFIGURAÇÕES DE RESUMO DE CAIXA              *}
  {** 20/03/2008 - 08:08 ***************************ER*}
  edtCodPorChv.Text      := fCfgSis('PORCHV');
  edtDesPortadorChv.Text := fRetNomPortador(edtCodPorChv.Text);
  edtCodPorChp.Text      := fCfgSis('PORCHP');
  edtDesPortadorChp.Text := fRetNomPortador(edtCodPorChp.Text);
  edtCodPorCrt.Text      := fCfgSis('PORCRT');
  edtDesPortadorCrt.Text := fRetNomPortador(edtCodPorCrt.Text);
  edtCodPorOrd.Text      := fCfgSis('PORORD');
  edtDesPortadorOrd.Text := fRetNomPortador(edtCodPorOrd.Text);
  edtCodPorFin.Text      := fCfgSis('PORFIN');
  edtDesPortadorFin.Text := fRetNomPortador(edtCodPorFin.Text);
//  edtCodPorRea.Text      := fCfgSis('PORREA');
//  edtDesPortadorRea.Text := fRetNomPortador(edtCodPorRea.Text);
//  edtCodPorDol.Text      := fCfgSis('PORDOL');
//  edtDesPortadorDol.Text := fRetNomPortador(edtCodPorDol.Text);
//  edtCodPorGua.Text      := fCfgSis('PORGUA');
//  edtDesPortadorGua.Text := fRetNomPortador(edtCodPorGua.Text);
//  edtCodPorEur.Text      := fCfgSis('POREUR');
//  edtDesPortadorEur.Text := fRetNomPortador(edtCodPorEur.Text);
//  edtCodPorPes.Text      := fCfgSis('PORPES');
//  edtDesPortadorPes.Text := fRetNomPortador(edtCodPorPes.Text);

  blnAltPtf := fCfgSis('ALTPTF', varBoolean);
  edtCodPorChv.Enabled := blnAltPtf;
  edtCodPorChp.Enabled := blnAltPtf;
  edtCodPorCrt.Enabled := blnAltPtf;
  edtCodPorOrd.Enabled := blnAltPtf;
  edtCodPorFin.Enabled := blnAltPtf;
  edtCodPorGua.Enabled := blnAltPtf;
  edtCodPorDol.Enabled := blnAltPtf;
  edtCodPorEur.Enabled := blnAltPtf;  
  edtCodPorPes.Enabled := blnAltPtf;
  edtCodPorRea.Enabled := blnAltPtf;

  If fCfgSis('RCXTCC') = '2' Then
  Begin
    btnSelChAvi.Visible := True;
    btnSelChPre.Visible := True;
    btnSelCartao.Visible := True;
    edtChqVistaTra.Enabled := False;
    edtChqPreTra.Enabled := False;
    edtCartaoTra.Enabled := False;

    lblTransf1.Caption      := 'Vr.Transferência';
    lblTransf2.Visible      := False;
    edtDinheiroTra2.Visible := False;
    edtChqVistaTra2.Visible := False;
    edtChqPreTra2.Visible   := False;
    edtCartaoTra2.Visible   := False;
    edtOrdPagTra2.Visible   := False;
    edtValFinTra2.Visible   := False;
    edtGuaTra2.Visible      := False;
    edtDolTra2.Visible      := False;
    edtEurTra2.Visible      := False;
    edtPesTra2.Visible      := False;
    edtReaTra2.Visible      := False;
    edtTotalTra2.Visible    := False;

    Self.Width := Self.Width - edtDinheiroTra2.Width;
  End
  Else
  Begin
    btnSelChAvi.Visible := False;
    btnSelChPre.Visible := False;
    btnSelCartao.Visible := False;

    edtDinheiroTra.Left := btnSelChAvi.Left - intLeftGroup;
    edtChqVistaTra.Left := btnSelChAvi.Left;
    edtChqPreTra.Left   := btnSelChAvi.Left;
    edtCartaoTra.Left   := btnSelChAvi.Left;
    edtOrdPagTra.Left   := btnSelChAvi.Left;
    edtValFinTra.Left   := btnSelChAvi.Left;
    edtGuaTra.Left      := btnSelChAvi.Left - intLeftGroup;
    edtDolTra.Left      := btnSelChAvi.Left - intLeftGroup;
    edtEurTra.Left      := btnSelChAvi.Left - intLeftGroup;
    edtPesTra.Left      := btnSelChAvi.Left - intLeftGroup;
    edtReaTra.Left      := btnSelChAvi.Left - intLeftGroup;
    edtTotalTra.Left    := btnSelChAvi.Left;
    lblTransf1.Left     := btnSelChAvi.Left;

    edtDinheiroTra2.Left := edtDinheiroTra.Left  + edtDinheiroTra.Width + 1 + intLeftGroup;
    edtChqVistaTra2.Left := edtDinheiroTra2.Left + intLeftGroup;
    edtChqPreTra2.Left   := edtDinheiroTra2.Left + intLeftGroup;
    edtCartaoTra2.Left   := edtDinheiroTra2.Left + intLeftGroup;
    edtOrdPagTra2.Left   := edtDinheiroTra2.Left + intLeftGroup;
    edtValFinTra2.Left   := edtDinheiroTra2.Left + intLeftGroup;
    edtGuaTra2.Left      := edtDinheiroTra2.Left;
    edtDolTra2.Left      := edtDinheiroTra2.Left;
    edtEurTra2.Left      := edtDinheiroTra2.Left;
    edtPesTra2.Left      := edtDinheiroTra2.Left;
    edtReaTra2.Left      := edtDinheiroTra2.Left;
    edtTotalTra2.Left    := edtDinheiroTra2.Left + intLeftGroup;
    lblTransf2.Left      := edtDinheiroTra2.Left + intLeftGroup;

    Self.Width := Self.Width - btnSelChAvi.Width;

    If Not fCfgSis('RCXTR2', varBoolean) Then
    Begin
      lblTransf1.Caption      := 'Vr.Transferência';
      lblTransf2.Visible      := False;
      edtDinheiroTra2.Visible := False;
      edtChqVistaTra2.Visible := False;
      edtChqPreTra2.Visible   := False;
      edtCartaoTra2.Visible   := False;
      edtOrdPagTra2.Visible   := False;
      edtValFinTra2.Visible   := False;
      edtGuaTra2.Visible      := False;
      edtDolTra2.Visible      := False;
      edtEurTra2.Visible      := False;
      edtPesTra2.Visible      := False;
      edtReaTra2.Visible      := False;
      edtTotalTra2.Visible    := False;

      Self.Width := Self.Width - edtDinheiroTra2.Width;
    End;

  End;

  If edtCodVendedor.CanFocus Then
    pSetFocus(edtCodVendedor)
  Else
  Begin
    If edtCodPorGua.CanFocus Then
      pSetFocus(edtCodPorGua)
    Else
      pSetFocus(edtGuaTra);
  End;

end;

procedure TfrmRcxTrasfValoresPar.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  pAtualizaValDig;

  If fVerificaCampos Then
  Begin

    If (fltDinhei <> 0) And ((fltGuaranie + fltDolar + fltPeso + fltEuro + fltReal) = 0) Then
    Begin
      fMensagem('','Especifique o total em dinheiro!',['&OK']);
      pSetFocus(edtCodPorGua);
      Exit;
    End

    Else If fltValTot < fltValDig Then
    Begin
      fMensagem('','Valor digitado está maior que o valor total!',['&OK']);
      pSetFocus(edtDinheiroTra);
    End

    Else If (fltValDig + IIf(fCfgSis('RCXTR2', varBoolean), fltValDi2, 0)) = 0 Then
    Begin
      fMensagem('','Valor digitado deve ser maior que zero!',['&OK']);
      pSetFocus(edtDinheiroTra);
    End

    Else
    Begin

      If (Not fEmptyStr(edtChqVistaTra.Text))                             And
         (fStrToFloat(edtChqVistaTra.Text) > 0.0)                         And
         (fMensagem('','Cheque a vista depositado?',['&Sim','&Não'], 2) = 1) Then
      Begin
        strDepos := 'S';
      End
      Else
        strDepos := 'N';

      Close;
      ModalResult := mrOk;

    End;

  End;

end;

procedure TfrmRcxTrasfValoresPar.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  inherited;
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorChvExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorChv, edtDesPortadorChv);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorChpExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorChp, edtDesPortadorChp);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorCrtExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorCrt, edtDesPortadorCrt);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorOrdExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorOrd, edtDesPortadorOrd);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorFinExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorFin, edtDesPortadorFin);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorFinKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  PEdtCodPorKeyPress(edtCodPorFin, edtDesPortadorFin,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorGuaExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorGua, edtDesPortadorGua);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorGuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorGua, edtDesPortadorGua,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorChvKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorChv, edtDesPortadorChv,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorChpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorChp, edtDesPortadorChp,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorCrtKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorCrt, edtDesPortadorCrt,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorDolExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorDol, edtDesPortadorDol);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorDolKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorDol, edtDesPortadorDol,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorEurExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorEur, edtDesPortadorEur);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorEurKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorEur, edtDesPortadorEur,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorOrdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorOrd, edtDesPortadorOrd,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorPesExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorPes, edtDesPortadorPes);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorPesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorPes, edtDesPortadorPes,Key);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorReaExit(Sender: TObject);
begin
  inherited;
  pEdtCodPorExit(edtCodPorRea, edtDesPortadorRea);
end;

procedure TfrmRcxTrasfValoresPar.edtCodPorReaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorRea, edtDesPortadorRea,Key);
end;

procedure TfrmRcxTrasfValoresPar.btnAltSeqFecClick(Sender: TObject);
  Var
    intSqFcRx: Integer;
begin
  inherited;
  intSqFcRx := fCfgSisL('SQFCRX');
  If fDigQuantidade('Seq. Fec. Parcial', 'Seq. fechamento parcial: ', intSqFcRx, intSqFcRx) Then
  Begin
    fAtuCfgSis('SQFCRX', IntToStr(intSqFcRx));
  End;
end;

procedure TfrmRcxTrasfValoresPar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F9 Then
    btnAltSeqFec.Click;
end;

procedure TfrmRcxTrasfValoresPar.btnSelChAviClick(Sender: TObject);
  Var
    frmRcxTransfDocs: TfrmRcxTransfDocs;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRcxTransfDocs, frmRcxTransfDocs);
    frmRcxTransfDocs.strCodOpe := edtCodVendedor.Text;
    frmRcxTransfDocs.strCodGpo := edtGruGpo.Text;
    frmRcxTransfDocs.objResumoDeCaixa := TResumoDeCaixa.Create('T');
    frmRcxTransfDocs.Caption := 'Transferência de Valores - Cheque A Vista';
    frmRcxTransfDocs.strOpcao := 'CHA';
    frmRcxTransfDocs.edtTotSel.Text := edtChqVistaTra.Text;
    If Not cdsChqAVi.IsEmpty Then
    Begin
      cdsChqAVi.Filtered := False;
      frmRcxTransfDocs.cdsConsulta.Data := cdsChqAVi.Data;
    End;
    frmRcxTransfDocs.showModal;

    If frmRcxTransfDocs.blnConfirma Then
    Begin
      edtChqVistaTra.Text := FormatFloat('#,###0.00',frmRcxTransfDocs.fltTotSel);
      cdsChqAVi.Data := frmRcxTransfDocs.cdsConsulta.Data;
      cdsChqAVi.Filtered := True;
    End
    Else
      edtChqVistaTra.Text := '0,00';

  Except
    On E: Exception Do
    Begin
      edtChqVistaTra.Text := '0,00';
      pMensagensErro(E.Message, '[frmRcxTrasfValoresPar.btnSelChAviClick]');
    End;
  End;

  pFreeAndNil(frmRcxTransfDocs);

  If edtCodPorChp.CanFocus Then
    pSetFocus(edtCodPorChp)
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRcxTrasfValoresPar.btnSelChPreClick(Sender: TObject);
  Var
    frmRcxTransfDocs: TfrmRcxTransfDocs;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRcxTransfDocs, frmRcxTransfDocs);
    frmRcxTransfDocs.strCodOpe := edtCodVendedor.Text;
    frmRcxTransfDocs.strCodGpo := edtGruGpo.Text;
    frmRcxTransfDocs.objResumoDeCaixa := TResumoDeCaixa.Create('T');
    frmRcxTransfDocs.Caption := 'Transferência de Valores - Cheque - Pré';
    frmRcxTransfDocs.strOpcao := 'CHP';
    frmRcxTransfDocs.edtTotSel.Text := edtChqPreTra.Text;
    If Not cdsChqPre.IsEmpty Then
    Begin
      cdsChqPre.Filtered := False;
      frmRcxTransfDocs.cdsConsulta.Data := cdsChqPre.Data;
    End;
    frmRcxTransfDocs.showModal;

    If frmRcxTransfDocs.blnConfirma Then
    Begin
      edtChqPreTra.Text := FormatFloat('#,###0.00',frmRcxTransfDocs.fltTotSel);
      cdsChqPre.Data := frmRcxTransfDocs.cdsConsulta.Data;
      cdsChqPre.Filtered := True;
    End
    Else
      edtChqPreTra.Text := '0,00';
      
  Except
    On E: Exception Do
    Begin
      edtChqPreTra.Text := '0,00';
      pMensagensErro(E.Message, '[frmRcxTrasfValoresPar.btnSelChPreClick]');
    End;
  End;

  pFreeAndNil(frmRcxTransfDocs);

  If edtCodPorCrt.CanFocus Then
    pSetFocus(edtCodPorCrt)
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRcxTrasfValoresPar.btnSelCartaoClick(Sender: TObject);
  Var
    frmRcxTransfDocs: TfrmRcxTransfDocs;
begin
  inherited;

  Try
    pCriarFormularios(TfrmRcxTransfDocs, frmRcxTransfDocs);
    frmRcxTransfDocs.strCodOpe := edtCodVendedor.Text;
    frmRcxTransfDocs.strCodGpo := edtGruGpo.Text;
    frmRcxTransfDocs.objResumoDeCaixa := TResumoDeCaixa.Create('T');
    frmRcxTransfDocs.Caption := 'Transferência de Valores - Cartão';
    frmRcxTransfDocs.strOpcao := 'CCA';
    frmRcxTransfDocs.edtTotSel.Text := edtCartaoTra.Text;
    If Not cdsCarCre.IsEmpty Then
    Begin
      cdsCarCre.Filtered := False;
      frmRcxTransfDocs.cdsConsulta.Data := cdsCarCre.Data;
    End;
    frmRcxTransfDocs.showModal;

    If frmRcxTransfDocs.blnConfirma Then
    Begin
      edtCartaoTra.Text := FormatFloat('#,###0.00',frmRcxTransfDocs.fltTotSel);
      cdsCarCre.Data := frmRcxTransfDocs.cdsConsulta.Data;
      cdsCarCre.Filtered := True;
    End
    Else
      edtCartaoTra.Text := '0,00';

  Except
    On E: Exception Do
    Begin
      edtCartaoTra.Text := '0,00';
      pMensagensErro(E.Message, '[frmRcxTrasfValoresPar.btnSelCartaoClick]');
    End;
  End;

  pFreeAndNil(frmRcxTransfDocs);

  If edtCodPorOrd.CanFocus Then
    pSetFocus(edtCodPorOrd)
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRcxTrasfValoresPar.FormCreate(Sender: TObject);
begin
  inherited;
   qryConPor := fCriaQuery(Self);
   qryCadOpe := fCriaQuery(Self);
   qryCadGpo := fCriaQuery(Self);
end;

procedure TfrmRcxTrasfValoresPar.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryCadOpe, Key, arrSel)  then
    Begin
      If fValidaCampos(edtCodVendedor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmRcxTrasfValoresPar.pCarregaVendedor(strCodVen: String);
begin
  pPesquisaCadOpe(Nil, qryCadOpe, edtCodVendedor.Text);
  edtDesVendedor.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
end;

procedure TfrmRcxTrasfValoresPar.pCarregaGrupoOpe(strCodGpo: String);
begin
  pPesquisaCadGpo(Nil, qryCadGpo, edtGruGpo.Text);
  edtDesGpo.Text := qryCadGpo.FieldByName('GPO_DESCRI').AsString;
end;

{***************************************}
{* VALIDA VALOR REFERENTE A MODALIDADE *}
{************************************AF*}
function TfrmRcxTrasfValoresPar.fValidaValorMod(fltValDig,
                                                fltValAtu: Double;
                                                strModalidade: String;
                                                edtPor: TEditFocus;
                                                blnDinheiro: Boolean = FALSE): Boolean;
Begin
  Result := True;

  If fltValDig > fltValAtu Then
  Begin
    fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser maior que o valor atual!',['&OK']);
    Result := False;
  End

  Else If fltValDig < 0 Then
  Begin
    fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser menor que zero!',['&OK']);
    Result := False;
  End

  Else If blnDinheiro Then
  Begin

  End

  Else If fEmptyStr(edtPor.Text) And (fltValDig > 0) Then
  Begin
    fMensagem('', 'Não foi escolhido portador para ' + strModalidade + '. O valor de transferência deve ser zero!', ['&OK']);
    Result := False;
  End;

End;

procedure TfrmRcxTrasfValoresPar.pCarregaValores;
  Var
    qryGen: TUniQuery;
    strSQL: String;
    fltSalFec: Double;
    dtaDtaFec: TDateTime;
Begin
  Try
    qryGen := fCriaQuery;

    pRetornaUltimoFechamento(fltSalFec, dtaDtaFec);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    strSQL := strSQL + '  SUM(RCX_DINREC) AS RCX_DINREC, ';
    strSQL := strSQL + '  SUM(RCX_CHQAVI) AS RCX_CHQAVI, ';
    strSQL := strSQL + '  SUM(RCX_CHQPRE) AS RCX_CHQPRE, ';
    strSQL := strSQL + '  SUM(RCX_CARREC) AS RCX_CARREC, ';
    strSQL := strSQL + '  SUM(RCX_ORDREC) AS RCX_ORDREC, ';
    strSQL := strSQL + '  SUM(RCX_VALFIN) AS RCX_VALFIN, ';

    strSQL := strSQL + '  SUM(RCX_TOTGUA) AS RCX_TOTGUA, ';
    strSQL := strSQL + '  SUM(RCX_TOTDOL) AS RCX_TOTDOL, ';
    strSQL := strSQL + '  SUM(RCX_TOTEUR) AS RCX_TOTEUR, ';
    strSQL := strSQL + '  SUM(RCX_TOTPES) AS RCX_TOTPES, ';
    strSQL := strSQL + '  SUM(RCX_TOTREA) AS RCX_TOTREA  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';

    If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

    strSQL := strSQL + 'WHERE ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + ' RCX_CODOPE = :CODOPE AND ';

    strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  ( RCX_DTACAD > :DTACAD OR ';
    strSQL := strSQL + '    (RCX_DTACAD = :DTACAD AND RCX_ESPDOC = "FC") ) ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODOPE').AsString := edtCodVendedor.Text;

      ParamByName('DTACAD').AsDate   := dtaDtaFec;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      edtDinheiroAtu.Text := FloatToStrF(FieldByName('RCX_DINREC').AsFloat,ffFixed,12,2);
      edtChqVistaAtu.Text := FloatToStrF(FieldByName('RCX_CHQAVI').AsFloat,ffFixed,12,2);
      edtChqPreAtu.Text   := FloatToStrF(FieldByName('RCX_CHQPRE').AsFloat,ffFixed,12,2);
      edtCartaoAtu.Text   := FloatToStrF(FieldByName('RCX_CARREC').AsFloat,ffFixed,12,2);
      edtOrdPagAtu.Text   := FloatToStrF(FieldByName('RCX_ORDREC').AsFloat,ffFixed,12,2);
      edtValFinAtu.Text   := FloatToStrF(FieldByName('RCX_VALFIN').AsFloat,ffFixed,12,2);

      edtGuaAtu.Text      := FloatToStrF(FieldByName('RCX_TOTGUA').AsFloat,ffFixed,12,2);
      edtDolAtu.Text      := FloatToStrF(FieldByName('RCX_TOTDOL').AsFloat,ffFixed,12,2);
      edtEurAtu.Text      := FloatToStrF(FieldByName('RCX_TOTEUR').AsFloat,ffFixed,12,2);
      edtPesAtu.Text      := FloatToStrF(FieldByName('RCX_TOTPES').AsFloat,ffFixed,12,2);
      edtReaAtu.Text      := FloatToStrF(FieldByName('RCX_TOTREA').AsFloat,ffFixed,12,2);

      Close;
    End;

    If fEmptyStr(edtDinheiroAtu.Text) Then edtDinheiroAtu.Text := '0,00';
    If fEmptyStr(edtChqVistaAtu.Text) Then edtChqVistaAtu.Text := '0,00';
    If fEmptyStr(edtChqPreAtu.Text)   Then edtChqPreAtu.Text   := '0,00';
    If fEmptyStr(edtCartaoAtu.Text)   Then edtCartaoAtu.Text   := '0,00';
    If fEmptyStr(edtOrdPagAtu.Text)   Then edtOrdPagAtu.Text   := '0,00';
    If fEmptyStr(edtValFinAtu.Text)   Then edtValFinAtu.Text   := '0,00';

    fltValTot := fStrToFloat(edtDinheiroAtu.Text) +
                 fStrToFloat(edtChqVistaAtu.Text) +
                 fStrToFloat(edtChqPreAtu.Text) +
                 fStrToFloat(edtCartaoAtu.Text) +
                 fStrToFloat(EdtOrdPagAtu.Text) +
                 fStrToFloat(EdtValFinAtu.Text);

    edtTotalAtu.Text := FloatToStrF(fltValTot,ffFixed,12,2);

    edtTotalTra.Text     := '0,00';
    edtDinheiroTra.Text  := '0,00';
    edtChqVistaTra.Text  := '0,00';
    edtChqPreTra.Text    := '0,00';
    edtCartaoTra.Text    := '0,00';
    edtOrdPagTra.Text    := '0,00';
    edtValFinTra.Text    := '0,00';
    edtTotalTra2.Text    := '0,00';
    edtDinheiroTra2.Text := '0,00';
    edtChqVistaTra2.Text := '0,00';
    edtChqPreTra2.Text   := '0,00';
    edtCartaoTra2.Text   := '0,00';
    edtOrdPagTra2.Text   := '0,00';
    edtValFinTra2.Text   := '0,00';

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmRcxTrasfValoresPar.pEscapePressed;
begin

  If ActiveControl.Parent = pnlFundo Then
  Begin

    If edtCodVendedor.CanFocus Then pSetFocus(edtCodVendedor)
    Else pSetFocus(edtGruGpo);

  End
  Else
    inherited;

end;

procedure TfrmRcxTrasfValoresPar.edtGruGpoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupo: TConsultasArray;

begin
  inherited;

  If fPesqGrupoOperador(Self, edtGruGpo, edtDesGpo, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(edtGruGpo, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRcxTrasfValoresPar.edtCodVendedorEnter(Sender: TObject);
begin
  inherited;

  strVenAnt := edtCodVendedor.Text;

  If Not blnOpeObr Then
  Begin
    edtGruGpo.Enabled := True;
    edtDesVendedor.Clear;
  End;

end;

procedure TfrmRcxTrasfValoresPar.edtGruGpoEnter(Sender: TObject);
begin
  inherited;
  edtCodVendedor.Enabled := True;
  edtDesGpo.Clear;
end;

Procedure TfrmRcxTrasfValoresPar.pTrataMoedas(blnEnable: Boolean);
Begin
  edtCodPorGua.Enabled := blnEnable;
  edtCodPorDol.Enabled := blnEnable;
  edtCodPorEur.Enabled := blnEnable;
  edtCodPorPes.Enabled := blnEnable;
  edtCodPorRea.Enabled := blnEnable;

  edtGuaTra.Enabled := blnEnable;
  edtDolTra.Enabled := blnEnable;
  edtEurTra.Enabled := blnEnable;
  edtPesTra.Enabled := blnEnable;
  edtReaTra.Enabled := blnEnable;

  If Not blnEnable Then
  Begin
    edtCodPorGua.Text := '';
    edtCodPorDol.Text := '';
    edtCodPorEur.Text := '';
    edtCodPorPes.Text := '';
    edtCodPorRea.Text := '';

    edtGuaTra.Text := '0,00';
    edtDolTra.Text := '0,00';
    edtEurTra.Text := '0,00';
    edtPesTra.Text := '0,00';
    edtReaTra.Text := '0,00';

    edtDesPortadorGua.Clear;
    edtDesPortadorDol.Clear;
    edtDesPortadorEur.Clear;
    edtDesPortadorPes.Clear;
    edtDesPortadorRea.Clear;
  End;

End;

end.



