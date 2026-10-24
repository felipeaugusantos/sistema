{***************************}
{* qryConCid -> CADCID     *}
{************************JB*}
{***************************}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untFiltroEtiFornecedores;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, untTypesSistema,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, untFuncoesSimples, BitBtnLockedIncrem,
  QColorLabel, frxClass, frxExportCSVTestabilidade;

type
  TfrmFiltroEtiFornecedores = class(TfrmPaiSimples)
    Label1: TLabel;
    Label2: TLabel;
    edtNomIni: TEditFocus;
    edtNomFin: TEditFocus;
    Label4: TLabel;
    edtCodAti: TEditFocus;
    Label6: TLabel;
    edtCodCid: TEditFocus;
    Label8: TLabel;
    edtBairro: TEditFocus;
    Label9: TLabel;
    edtEstado: TEditFocus;
    Label10: TLabel;
    edtQtdEti: TEditFocus;
    edtNomAti: TEditFocus;
    edtNomCid: TEditFocus;
    pnlFundo: TPanel;
    chkMosFil: TCheckBox;
    lbl1: TLabel;
    edtRevist: TEditFocus;
    ColorLabel1: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConCid: TUniQuery;
    qryCadCid: TUniQuery;

    procedure pCarregaCidade;

    procedure pAtribuiTabelas;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;

    strNomIni: String;
    strNomFin: String;
    strCodAti: String;
    strCodCid: String;
    strBairro: String;
    strEstado: String;
    strRevist: String;
    intQtdEti: Integer;

    arrCidade   : TConsultasArray;
    arrAtividade: TConsultasArray;
  end;


implementation

uses untPesqAux, untFuncoesConsulta, untConsultas;

{$R *.dfm}

{ TfrmFiltroEtiFornecedores }

function TfrmFiltroEtiFornecedores.fValidaCampos(Sender: TWinControl;
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
    {* VALIDA A ATIVIDADE                    *}
    {**************************************MV*}
    Else If (Sender = edtCodAti) Then
    Begin
      If fEmptyStr(edtCodAti.Text) Then
      Begin
        edtNomAti.Clear;
      End
      Else
      Begin
        pEdtCodSelectExit(edtCodAti, edtNomAti, arrAtividade, nil, fRetNomAtividade, 'da Atividade');
        If fEmptyStr(edtCodAti.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa atividade não está cadastrada!', ['&O k']);
          Result := False;
        End;
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

    {**************************}
    {* VALIDA O CAMPO REVISTA *}
    {***********************PZ*}
    Else If (sender = edtRevist) Then
    Begin
      If (Pos(edtRevist.Text, 'SN') <= 0) And (Not fEmptyStr(edtRevist.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Revista deve ser S ou N.',['&O k']);
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
          strCodAti := edtCodAti.Text;
          strCodCid := edtCodCid.Text;
          strBairro := edtBairro.Text;
          strEstado := edtEstado.Text;
          strRevist := edtRevist.Text;          
          intQtdEti := StrToInt(edtQtdEti.Text);

          Close;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFiltroEtiFornecedores.pCarregaCidade;
begin
  pPesquisaCadCid(qryCadCid, qryConCid, edtCodCid.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
  End;
end;

procedure TfrmFiltroEtiFornecedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmFiltroEtiFornecedores.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  pAtribuiTabelas;
end;

procedure TfrmFiltroEtiFornecedores.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtNomAti, Nil, Key, arrAtiv) Then
  Begin
    if fValidaCampos(edtCodAti, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiFornecedores.edtCodCidKeyPress(Sender: TObject;
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
    if fValidaCampos(edtCodCid, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiFornecedores.pAtribuiTabelas;
begin
  qryCadCid := fCriaQuery(Self);
  qryConCid := qryCadCid;
end;

end.

