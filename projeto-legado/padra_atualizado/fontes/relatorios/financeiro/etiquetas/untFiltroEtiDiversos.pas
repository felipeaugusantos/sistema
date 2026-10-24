{****************************}
{* qryConCid -> CADCID      *}
{*************************JB*}
{****************************}
{* qryCadCid -> CADCID      *}
{*************************RV*}
unit untFiltroEtiDiversos;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, untTypesSistema,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Menus, AppEvnts, Mask, MaskEditFocus,untFuncoesSimples,
  BitBtnLockedIncrem;

type
  TfrmFiltroEtiDiversos = class(TfrmPaiSimples)
    Label1: TLabel;
    Label2: TLabel;
    edtNomIni: TEditFocus;
    edtNomFin: TEditFocus;
    Label6: TLabel;
    edtCodCid: TEditFocus;
    Label8: TLabel;
    edtBairro: TEditFocus;
    Label9: TLabel;
    edtEstado: TEditFocus;
    Label10: TLabel;
    edtQtdEti: TEditFocus;
    edtNomCid: TEditFocus;
    pnlFundo: TPanel;
    chkMosFil: TCheckBox;
    gpbAniv: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    mskAniIni: TMaskEditFocus;
    mskAniFin: TMaskEditFocus;
    gpb1: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label4: TLabel;
    edtCodAti: TEditFocus;
    edtNomAti: TEditFocus;
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
  private
    { Private declarations }
    qryConCid: TUniQuery;
    qryCadCid: TUniQuery;

    procedure pCarregaCidade;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    strNomIni: String;
    strNomFin: String;
    strCodCid: String;
    strCodAti: String;
    strBairro: String;
    strEstado: String;
    intQtdEti: Integer;
    strAniIni: String;
    strAniFin: String;
    strDtaIni: String;
    strDtaFin: String;

    blnConfirma: Boolean;

    arrAtividade: TConsultasArray;

    
  end;


implementation

uses untFuncoesConsulta, untPesqAux, untConsultas;

{$R *.dfm}

{ TfrmFiltroEtiDiversos }

function TfrmFiltroEtiDiversos.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*****************************************}
    {* VALIDA O NOME INICIAL                 *}
    {**************************************MV*}
    If (Sender = edtNomIni) Then
    Begin
      If fEmptyStr(edtNomIni.Text) Then
      Begin
        edtNomFin.Enabled := False;
      End
      Else
      Begin
        edtNomFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA O NOME FINAL                   *}
    {**************************************MV*}
    Else If (Sender = edtNomFin) Then
    Begin
      If edtNomIni.Text > edtNomFin.Text Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome Final não pode ser menor que o Inicial', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A CIDADE                       *}
    {**************************************MV*}
    Else If (Sender = edtCodCid) Then
    Begin
      If fEmptyStr(edtCodCid.Text) Then
      Begin
        edtNomCid.Clear;
      End
      Else
      Begin
        pCarregaCidade;
        If qryConCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O BAIRRO                       *}
    {**************************************MV*}
    Else If (Sender = edtBairro) Then
    Begin
    End

    {*****************************************}
    {* VALIDA O ESTADO                       *}
    {**************************************MV*}
    Else If (Sender = edtEstado) Then
    Begin
      If Not fEmptyStr(edtEstado.Text) Then
      Begin
        If (Not fValidaEstado(edtEstado.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', edtEstado.Text + ' não é um Estado válido!', ['&O k']);
          edtEstado.Clear;
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA PERÍODO DE VENDA               *}
    {**************************************RV*}
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    {*****************************************}
    {* VALIDA O DIA/MÊS DE ANIVERSÁRIO       *}
    {**************************************RV*}
    Else If (Sender = mskAniIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text)) Then
      Begin
        mskAniFin.Enabled := False;
      End
      Else
      Begin
        mskAniFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA O DIA/MÊS DE ANIVERSÁRIO       *}
    {**************************************MV*}
    Else If (Sender = mskAniFin) Then
    Begin
      If (mskAniIni.Text > mskAniFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Dia/Mês Final não pode ser menor que o Inicial', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A QUANTIDADE DE ETIQUETAS      *}
    {**************************************MV*}
    Else If (Sender = edtQtdEti) Then
    Begin
      If fEmptyStr(edtQtdEti.Text) Then
      Begin
        Result := False;
      End
      Else
      Begin
        If fMensagem('', 'Confirma dados do filtro?', ['&Sim', '&Não']) = 1 Then
        Begin
          blnConfirma := True;

          strNomIni := edtNomIni.Text;
          strNomFin := edtNomFin.Text;
          strCodCid := edtCodCid.Text;
          strCodAti := edtCodAti.Text;
          strBairro := edtBairro.Text;
          strEstado := edtEstado.Text;
          intQtdEti := StrToInt(edtQtdEti.Text);
          strAniIni := mskAniIni.Text;
          strAniFin := mskAniFin.Text;
          strDtaIni := mskDtaIni.Text;
          strDtaFin := mskDtaFin.Text;

          Close;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFiltroEtiDiversos.pCarregaCidade;
begin
  pPesquisaCadCid(qryCadCid, qryConCid, edtCodCid.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
  End;
end;

procedure TfrmFiltroEtiDiversos.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtNomAti, arrAtividade, nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmFiltroEtiDiversos.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************PE*}
  If fPesqAtividade(Self, edtCodAti, edtNomAti, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmFiltroEtiDiversos.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiDiversos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmFiltroEtiDiversos.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadCid := fCriaQuery(Self);
  qryConCid := qryCadCid;
end;

end.

