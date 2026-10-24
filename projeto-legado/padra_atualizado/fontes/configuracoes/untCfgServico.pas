{*****************************}
{* qryConIte -> CADITE       *}
{* qryConSer -> CADSER       *}
{**************************JB*}
unit untCfgServico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus, QColorLabel, EditFocus, Uni, AppEvnts;

type
  TfrmCfgServico = class(TfrmPai)
    pnlCentral: TPanel;
    btnGravar: TBitBtn;
    Label109: TLabel;
    ColorLabel52: TColorLabel;
    dbeUsaSer: TDBEditFocus;
    dbeIteSer: TDBEditFocus;
    Label1: TLabel;
    edtDesIte: TEditFocus;
    Label2: TLabel;
    ColorLabel1: TColorLabel;
    dbeEdiSer: TDBEditFocus;
    Label3: TLabel;
    dbePerIss: TDBEditFocus;
    Label5: TLabel;
    dbeLinSer: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure dbeIteSerKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeUsaSerExit(Sender: TObject);
  private
    { Private declarations }
    qryConIte: TUniQuery;
    qryConSer: TUniQuery;

    procedure pCarregaProduto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgServico: TfrmCfgServico;

implementation

uses untPesqAux, untModuloCadIte, untFuncoes, untfuncoesSimples,
  untModuloCadSer;

{$R *.dfm}

procedure TfrmCfgServico.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

function TfrmCfgServico.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeUsaSer) Then
  Begin

    If (Sender = dbeUsaSer) Then
    Begin
      If fEmptyStr(dbeUsaSer.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Usa serviço" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Copy(dbeUsaSer.Text, 1, 1) <> 'S') And
              (Copy(dbeUsaSer.Text, 1, 1) <> 'N') Then
      Begin
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeIteSer) Then
  Begin
    If fEmptyStr(dbeIteSer.Text) And (dbeUsaSer.Text <> 'N') Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (dbeUsaSer.Text <> 'N') Then
    Begin
      pCarregaProduto;
      If qryConIte.FieldByName('ITE_CODITE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
        Result := False;
      End;

    End;
  End

  Else If (Sender = dbeEdiSer) Then
  Begin
    If (Sender = dbeEdiSer) Then
    Begin
      If fEmptyStr(dbeEdiSer.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Edita serviço" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Copy(dbeEdiSer.Text, 1, 1) <> 'S') And
              (Copy(dbeEdiSer.Text, 1, 1) <> 'N') Then
      Begin
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbePerIss) Then
  Begin

    If (fEmptyStr(dbePerIss.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de ISS deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaEscala(dbePerIss.Text, 0, 99.99)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de ISS deve estar entre 0 e 99.99', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeLinSer) Then
  Begin
    If (fEmptyStr(dbeLinSer.Text)) Then
    Begin
      Result := False;
    End
    Else If (StrToInt(dbeLinSer.Text) < 1) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de linhas de serviço deve ser maior que 1.', ['&Ok']);
      Result := False;
    End
    Else If (StrToInt(dbeLinSer.Text) > 6) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de linhas de serviço deve ser menor que 6.', ['&Ok']);
      Result := False;
    End;
  End;

end;

procedure TfrmCfgServico.pCarregaProduto;
begin
  pPesquisaCadIte(frmModuloCadIte.qryCadIte, qryConIte, dbeIteSer.Text);
  With qryConIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCfgServico.dbeIteSerKeyPress(Sender: TObject; var Key: Char);
  Var
    strSQL: String;
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
begin

  stlCamIndIte := TStringList.Create;
  stlDesIndIte := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamIndIte.Add('ITE_DESITE+ITE_REFERE');
    stlCamIndIte.Add('ITE_CODITE');
    stlCamIndIte.Add('ITE_REFERE');
    stlCamIndIte.Add('ITE_CODGRU');
    stlCamIndIte.Add('ITE_CODBAR');
    stlCamIndIte.Add('ITE_CODFAB');
    stlCamIndIte.Add('ITE_CODMAR');

    stlDesIndIte.Add('Descrição/Referencia');
    stlDesIndIte.Add('Código');
    stlDesIndIte.Add('Referencia');
    stlDesIndIte.Add('Grupo');
    stlDesIndIte.Add('Cód. Barra');
    stlDesIndIte.Add('Cód. Fábrica');
    stlDesIndIte.Add('Cód. Marca');

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODGRU AS "Grupo", ';
    strSQL := strSQL + '  ITE_CODITE AS "Código", ';
    strSQL := strSQL + '  ITE_DESITE AS "Descrição", ';
    strSQL := strSQL + '  ITE_REFERE AS "Referencia", ';
    strSQL := strSQL + '  ITE_CODUNI AS "Cód. Unidade", ';
    strSQL := strSQL + '  UNI_DESUNI AS "Unidade", ';
    strSQL := strSQL + '  ITE_CODMAR AS "Cód. Marca", ';
    strSQL := strSQL + '  MAR_DESMAR AS "Marca", ';
    strSQL := strSQL + '  ITE_CODBAR AS "Cód. Barra", ';
    strSQL := strSQL + '  ITE_CODFAB AS "Cód. Fabricação", ';
    strSQL := strSQL + '  CADITE.AUTOINCREM AS "AUTOINCREM" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE, ';
    strSQL := strSQL + '  CADUNI, ';
    strSQL := strSQL + '  CADMAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODUNI = UNI_CODUNI AND ';
    strSQL := strSQL + '  ITE_CODMAR = MAR_CODMAR ';

    If pConsultaComp(Self, qryConIte, 'CADITE', strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin
      dbeIteSer.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
      If (fValidaCampos(dbeIteSer, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  End;

  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
end;

procedure TfrmCfgServico.FormCreate(Sender: TObject);
begin
  inherited;
  qryConIte := frmModuloCadIte.qryCadIte;
  qryConSer := frmModuloCadSer.qryCadSer;
end;

procedure TfrmCfgServico.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaProduto;
end;

procedure TfrmCfgServico.dbeUsaSerExit(Sender: TObject);
begin
  inherited;

  If dbeUsaSer.Text = 'N' Then
  Begin
    dbeIteSer.Clear;
    edtDesIte.Clear;
    Self.SelectNext(ActiveControl, True, True);
    dbeIteSer.Enabled := False;
  End
  Else
  Begin
    dbeIteSer.Enabled := True;
    dbeIteSer.SetFocus;
  End;  

end;

initialization
  RegisterClass(TfrmCfgServico);
finalization
  UnRegisterClass(TfrmCfgServico);

end.

