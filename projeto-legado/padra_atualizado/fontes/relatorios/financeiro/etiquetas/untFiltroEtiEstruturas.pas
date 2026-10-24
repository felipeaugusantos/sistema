unit untFiltroEtiEstruturas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, Mask, MaskEditFocus, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Uni, BitBtnLockedIncrem;

type
  TfrmFiltroEtiEstruturas = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    edtQtdEti: TEditFocus;
    edtLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    chkMosFil: TCheckBox;
    procedure edtLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryConGru: TUniQuery;

    procedure pCarregaLinGru;

    procedure pAtribuiTabelas;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    strDesIni: String;
    strDesFin: String;
    strLinGru: String;
    intQtdEti: Integer;

    blnConfirma: Boolean;
  end;

var
  frmFiltroEtiEstruturas: TfrmFiltroEtiEstruturas;

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmFiltroEtiEstruturas.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*****************************************}
    {* VALIDA A DESCRIÇÃO INICIAL            *}
    {**************************************MV*}
    If (Sender = edtDesIni) Then
    Begin
      If fEmptyStr(edtDesIni.Text) Then
      Begin
        edtDesFin.Enabled := False;
      End
      Else
      Begin
        edtDesFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO FINAL              *}
    {**************************************MV*}
    Else If (Sender = edtDesFin) Then
    Begin
      If edtDesIni.Text > edtDesFin.Text Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição Final não pode ser menor que o Inicial', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A LINHA / GRUPO                *}
    {**************************************MV*}
    Else If (Sender = edtLinGru) Then
    Begin

      If fEmptyStr(edtLinGru.Text) Then
      Begin
        edtDesGru.Clear;
      End
      Else
      Begin
        pCarregaLinGru;
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
          Result := False;
        End;
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

          strDesIni := edtDesIni.Text;
          strDesFin := edtDesFin.Text;
          strLinGru := edtLinGru.Text;
          intQtdEti := StrToInt(edtQtdEti.Text);

          Close;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFiltroEtiEstruturas.pCarregaLinGru;
begin
  pPesquisaLinGru(qryConGru, qryConGru, edtLinGru.Text);
  With qryConGru Do
  Begin
    edtDesGru.Text := FieldByName('GRU_DESGRU').AsString;
  End;
end;

procedure TfrmFiltroEtiEstruturas.edtLinGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, edtLinGru, edtDesGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(edtLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiEstruturas.pAtribuiTabelas;
begin
  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
end;

procedure TfrmFiltroEtiEstruturas.FormCreate(Sender: TObject);
begin
  inherited;
  pAtribuiTabelas;
end;

end.
