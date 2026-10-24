unit untCadGlobalColorEmbalagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, StrUtils, AppEvnts, Uni, BitBtnLockedIncrem,
  DB, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadGlobalColorEmbalagens = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeCodEmb: TDBEditFocus;
    Label2: TLabel;
    dbeQtdEmb: TDBEditFocus;
    Label3: TLabel;
    dbeUnidad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }

    dtsGlo_CadBas: TDataSource;
    procedure pLigarDataSets;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadGlobalColorEmbalagens: TfrmCadGlobalColorEmbalagens;

implementation

uses untPai, untModuloTinta,
    untConstantes, untFuncoesSimples, untFuncoesConsulta, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCadGlobalColorEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'GLO_CADEMB';
  strNomeCampo  := 'EMB_CODEMB';
  qryTabela     := frmModuloTinta.qryGlo_CadEmb;

  dtsGlo_CadBas := fCriaDataSource(qryTabela);

  pLigarDataSets;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
End;
procedure TfrmCadGlobalColorEmbalagens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadGlobalColorEmbalagens.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key   : Char;
begin
  Key := '/';
  If fPesqEmbalagens(Self, 'GLO_CADEMB', Nil, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);

end;

procedure TfrmCadGlobalColorEmbalagens.dbeUnidadKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
    if fPesqUnidade(Self, dbeUnidad, nil, nil, nil, Key, arrSel) then
      if fValidaCampos(dbeUnidad, True) then
        SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadGlobalColorEmbalagens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodEmb.Enabled := False;
  pSetFocus(dbeQtdEmb);
end;

function TfrmCadGlobalColorEmbalagens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodEmb) Then
  Begin

    If (fEmptyStr(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      fBuscaPorCamposChave;
    End;

  End

  Else If (Sender = dbeQtdEmb) Then
  Begin

    If (fEmptyStr(dbeQtdEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbeQtdEmb.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero! ', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeUnidad) Then
  Begin
    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else
    Begin

      If fEmptyStr(fRetNomUnidade(dbeUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
        Result := False;
      End

      Else If (Pos(dbeUnidad.Text, 'QT_LT_GL_LA_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr('QT_LT_GL_LA_', '_', ' ') + ')', ['&Ok']);
        Result := False;
      End;

    End;

  End;

end;

procedure TfrmCadGlobalColorEmbalagens.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EMB_CODEMB');
  stlCampos.Add('EMB_QTDEMB');
  stlCampos.Add('EMB_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EMB_CODEMB');
  stlDesInd.Add('Código');
end;

procedure TfrmCadGlobalColorEmbalagens.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin

    If (Components[intCont] is TDBEdit) Then
      TDBEdit(Components[intCont]).DataSource := dtsGlo_CadBas
    Else If (Components[intCont] is TDBCheckBox) Then
      TDBCheckBox(Components[intCont]).DataSource := dtsGlo_CadBas;

  End;
end;

end.

