unit Contabilidade.View.DemonstracaoMutacaoPatrimonioLiquidoHistMov;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiCadContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmDMPLHistoricoMovimentacao = class(TfrmPaiCadContabilidade)
    Label1: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dtsHistMov: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmDMPLHistoricoMovimentacao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmDMPLHistoricoMovimentacao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmDMPLHistoricoMovimentacao.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrTip: TConsultasArray;
begin
  chrKey := '/';
  If fPesqHistoricoMovimentacao(Self, Nil, Nil, qryTabela, chrKey, arrTip) Then
  begin
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmDMPLHistoricoMovimentacao.FormCreate(Sender: TObject);
begin
  inherited;
  Self.blnVerDirEsp := False;

  strNomeTabela     := 'HISTMV';
  strNomeCampo      := 'HST_CODIGO';

  qryTabela         := fCriarQuery('SELECT * FROM HISTMV', Self);
  dtsHistMov.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmDMPLHistoricoMovimentacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&OK']);
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
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&OK']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmDMPLHistoricoMovimentacao.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('HST_CODIGO');
  stlCampos.Add('HST_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('HST_DESCRI');
  stlCamInd.Add('HST_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

end.
