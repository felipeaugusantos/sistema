unit untCadLksGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadLksGeraArquivo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    tmrProgresso: TTimer;
    memStatus: TMemo;
    pnlTopo: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
    procedure pMostraResumo(stlColCad, stlBasCad, stlTintasNaoGer: TStringList;
        strMensagem: String);
  public
    { Public declarations }
    procedure pLimparTabela(tabela: String);
  end;

var
  frmCadLksGeraArquivo: TfrmCadLksGeraArquivo;

implementation

uses  untLukscolor, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadLksGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    stlColCad       : TStringList;
    stlBasCad       : TStringList;
    stlTintasNaoGer : TStringList;
    strMensagem     : String;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin

    stlColCad       := TStringList.Create;
    stlBasCad       := TStringList.Create;
    stlTintasNaoGer := TStringList.Create;

    pnlInfo.Caption := 'Gerando arquivo (LUKSCOLOR), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    If (fLukscolorGeraArquivo(stlColCad, stlBasCad, stlTintasNaoGer, strMensagem)) Then
    Begin
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
      Close;
    End
    Else
    Begin
      pMostraResumo(stlColCad, stlBasCad, stlTintasNaoGer, strMensagem);
      btnSair.Enabled := True;
    End;

    FreeAndNil(stlColCad);
    FreeAndNil(stlBasCad);
    FreeAndNil(stlTintasNaoGer);

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
  End;
end;

procedure TfrmCadLksGeraArquivo.pMostraResumo(stlColCad, stlBasCad,
  stlTintasNaoGer: TStringList; strMensagem: String);
  Var
    intContador: Integer;
begin

  If (Not fEmptyStr(strMensagem)) Then
  Begin
    memStatus.Lines.Add(strMensagem);
  End;

  If (stlColCad.Count > 0) Then
  Begin

    memStatus.Lines.Add('');
    memStatus.Lines.Add('COLORANTES CADASTRADOS NA GERAÇÃO:');
    memStatus.Lines.Add('');

    For intContador := 0 To stlColCad.Count -1 Do
    Begin
      memStatus.Lines.Add(stlColCad[intContador]);
    End;

  End;

  If (stlBasCad.Count > 0) Then
  Begin

    memStatus.Lines.Add('');
    memStatus.Lines.Add('BASES CADASTRADAS NA GERAÇÃO:');
    memStatus.Lines.Add('');

    For intContador := 0 To stlBasCad.Count -1 Do
    Begin
      memStatus.Lines.Add(stlBasCad[intContador]);
    End;

  End;

  Self.Height := Self.Height + memStatus.Height;
end;

procedure TfrmCadLksGeraArquivo.tmrProgressoTimer(Sender: TObject);
begin
  inherited;
  If strDirecao = 'D' Then
  Begin

    pnlProgInterno.Left := pnlProgInterno.Left + 5;

    If pnlProgInterno.Left + pnlProgInterno.Width >= pnlCentral.Width Then
      strDirecao := 'E';

  End
  Else
  Begin
    pnlProgInterno.Left := pnlProgInterno.Left - 5;

    If pnlProgInterno.Left <= 0 Then
      strDirecao := 'D';
  End;
end;

procedure TfrmCadLksGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Height := Self.Height - memStatus.Height;
end;

procedure TfrmCadLksGeraArquivo.pLimparTabela(tabela: String);
var
  Query: TUniQuery;
begin
  Query := fCriaQuery();
  Query.Close;
  Query.SQL.Text := 'TRUNCATE TABLE ' + Tabela;
  Query.ExecSQL;
  FreeAndNil(Query);
end;

end.
