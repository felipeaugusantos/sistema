unit Contabilidade.View.TipoDaTabelaDinamicaDoEcf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Contabilidade.View.TfrmPaiCadContabilidade, frxClass, frxExportCSVTestabilidade;

type
  TfrmTipoDaTabelaDinamicaDoEcf = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsTabEcf: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmTipoDaTabelaDinamicaDoEcf: TfrmTipoDaTabelaDinamicaDoEcf;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmTipoDaTabelaDinamicaDoEcf.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmTipoDaTabelaDinamicaDoEcf.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmTipoDaTabelaDinamicaDoEcf.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrHist: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoDaTabelaDinamicaDoEcf(Self, Nil, Nil, qryTabela, chrKey, arrHist) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmTipoDaTabelaDinamicaDoEcf.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'TABECF';
  strNomeCampo      := 'ECF_CODIGO';

  qryTabela         := fCriarQuery('SELECT * FROM TABECF', Self);
  dtsTabEcf.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

function TfrmTipoDaTabelaDinamicaDoEcf.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin

    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do tipo da tabela dinâmica do ECF deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDescri) Then
  Begin
    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do tipo da tabela dinâmica do ECF deve ser preenchido!', ['&OK']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmTipoDaTabelaDinamicaDoEcf.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ECF_CODIGO');
  stlCampos.Add('ECF_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ECF_DESCRI');
  stlCamInd.Add('ECF_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

end.
