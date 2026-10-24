unit untCadBzaGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,  BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBzaGeraArquivo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    tmrProgresso: TTimer;
    pnlTopo: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    pnlMemo: TPanel;
    memStatus: TMemo;
    rdbGerBas: TRadioButton;
    rdbGerCor: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
    intTamMemo: Integer;
  public
    { Public declarations }
  end;

var
  frmCadBzaGeraArquivo: TfrmCadBzaGeraArquivo;

implementation

uses untFuncTinta, untFuncoesSimples,
     untIConfTinta, untBrasimixAutomotivaDinamica;

{$R *.dfm}

procedure TfrmCadBzaGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    stlTintasNaoGeradas: TStringList;
    stlBasesNaoCad: TStringList;
    intContador: Integer;
    conf: IConfTinta;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin

    conf  := fGetConfTinta('BZA');
    stlTintasNaoGeradas := TStringList.Create;
    stlBasesNaoCad      := TStringList.Create;

    pnlInfo.Caption := 'Gerando arquivo (BRASIMIX AUTOMOTIVA), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    If fImportarArquivoBrasimix(pnlInfo, stlTintasNaoGeradas, stlBasesNaoCad, rdbGerBas.Checked) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok'])
    Else
      fMensagem('', 'Não foi possivel gerar o arquivo!', ['&Ok']);

    If (stlBasesNaoCad.Count > 0) Then
    Begin

      Self.Height := Self.Height + intTamMemo;

      memStatus.Lines.Add('Bases não cadastradas:');
      memStatus.Lines.Add('');

      For intContador := 0 To stlBasesNaoCad.Count -1 Do
      Begin
        memStatus.Lines.Add(stlBasesNaoCad[intContador]);
      End;

      memStatus.Lines.Add('');
      memStatus.Lines.Add('Tintas não geradas:');
      memStatus.Lines.Add('');
      For intContador := 0 To stlTintasNaoGeradas.Count -1 Do
      Begin
        memStatus.Lines.Add(stlTintasNaoGeradas[intContador]);
      End;

    End
    Else
    Begin
      Close;
    End;

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';

    FreeAndNil(stlTintasNaoGeradas);
    FreeAndNil(stlBasesNaoCad);

  End;
end;

procedure TfrmCadBzaGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadBzaGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  intTamMemo  := pnlMemo.Height + pnlCabecalho.Height;
  Self.Height := Self.Height - intTamMemo + 15;
end;

end.
