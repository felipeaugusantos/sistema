unit untCadReiCores;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, AppEvnts, BitBtnLockedIncrem, Data.DB, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadReiCores = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodPro: TDBEditFocus;
    pnlFundo: TPanel;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    dtsCadReiCores: TDataSource;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadReiCores: TfrmCadReiCores;

implementation

uses untModuloTinta,  untPai,
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadReiCores.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryRei_CadCor;
  strNomeTabela := 'REI_CADCOR';
  strNomeCampo  := 'COR_CODPRO';

  dtsCadReiCores.DataSet := frmModuloTinta.qryRei_CadCor;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'COR_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsRei_CadCor;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodPro;
  arrCamposChave[1] := dbeCodEmp;
end;

function TfrmCadReiCores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodPro) Then
    Begin

      If (fEmptyStr(dbeCodPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          pLimparCampos;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO                    *}
    {**************************************MV*}
    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadReiCores.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COR_CODPRO');
  stlCampos.Add('COR_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COR_DESCRI');
  stlCamInd.Add('COR_CODPRO');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadReiCores.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  qryTabela.FieldByName('COR_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodPro);
end;

procedure TfrmCadReiCores.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  if fPesqRei_cadCor(Self, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadReiCores.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodPro.Enabled := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

end.

