unit untConfiguracoesLazzumixLinhas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, BitBtnLockedIncrem, untAutcomTintaFactory,
  untIDataSet;

type
  TfrmConfiguracoesLazzumixLinhas = class(TForm)
    pnlCentro: TPanel;
    lsbDisponiveis: TListBox;
    lsbUtilizadas: TListBox;
    btnAdicionar: TSpeedButton;
    btnAdicionarTodos: TSpeedButton;
    btnRemoverTodos: TSpeedButton;
    btnRemover: TSpeedButton;
    pnlConfirma: TPanel;
    btnSair: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAdicionarTodosClick(Sender: TObject);
    procedure btnRemoverTodosClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure lsbDisponiveisDblClick(Sender: TObject);
    procedure lsbUtilizadasDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
//    dicLinhas: TDicionario;
    FQryLinhas: IDataSet;
    procedure pAbrirCadastroLinhas;
    procedure pMover(lsbOrigem, lsbDestino: TListBox);

    procedure pAdicionar;
    procedure pAdicionarTudo;

    procedure pRemover;
    procedure pRemoverTudo;

    procedure pOrdenarListas;

    procedure pPreencherListas;
//    function fRetornaCodigoLinha(strLinhaBusca: String): String;
  public
    { Public declarations }
    strConfigAtual: String;
    function getLinhasUtilizadas: String;
  end;


var
  frmConfiguracoesLazzumixLinhas: TfrmConfiguracoesLazzumixLinhas;

implementation

{$R *.dfm}

{ TfrmConfiguracoesLazzumixLinhas }

procedure TfrmConfiguracoesLazzumixLinhas.btnAdicionarClick(Sender: TObject);
begin
  pAdicionar;
end;

procedure TfrmConfiguracoesLazzumixLinhas.btnAdicionarTodosClick(
  Sender: TObject);
begin
  pAdicionarTudo;
end;

procedure TfrmConfiguracoesLazzumixLinhas.btnGravarConfClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmConfiguracoesLazzumixLinhas.btnRemoverClick(Sender: TObject);
begin
  pRemover;
end;

procedure TfrmConfiguracoesLazzumixLinhas.btnRemoverTodosClick(Sender: TObject);
begin
  pRemoverTudo;
end;

procedure TfrmConfiguracoesLazzumixLinhas.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracoesLazzumixLinhas.FormCreate(Sender: TObject);
begin
  pAbrirCadastroLinhas;
end;

procedure TfrmConfiguracoesLazzumixLinhas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmConfiguracoesLazzumixLinhas.FormShow(Sender: TObject);
begin
  pPreencherListas;
end;

function TfrmConfiguracoesLazzumixLinhas.getLinhasUtilizadas: String;
  Var
    intContador: Integer;
    strLinha: String;
begin
  Result := '';
  strLinha := '';

  For intContador := 0 To lsbUtilizadas.Count - 1 Do
  Begin
    strLinha := lsbUtilizadas.Items[intContador]; //dicLinhas[lsbUtilizadas.Items[intContador]];

    FQryLinhas.First;
    While Not FQryLinhas.Eof Do
    Begin
      If strLinha = FQryLinhas.FieldByName('MIX_REFERE').AsString Then
      Begin
        Result := Result + FQryLinhas.FieldByName('MIX_REFERE').AsString;
        Break;
      End;

      FQryLinhas.Next;
    End;
  End;
end;

procedure TfrmConfiguracoesLazzumixLinhas.lsbDisponiveisDblClick(
  Sender: TObject);
begin
  pAdicionar;
end;

procedure TfrmConfiguracoesLazzumixLinhas.lsbUtilizadasDblClick(
  Sender: TObject);
begin
  pRemover;
end;

procedure TfrmConfiguracoesLazzumixLinhas.pAbrirCadastroLinhas;
begin
  FQryLinhas := TAutcomTintaFactory.Get.fGetDataSet;
  FQryLinhas.SQL := 'SELECT DISTINCT MIX_REFERE FROM LAZ_CADMIX; ';
  FQryLinhas.Open;
end;

procedure TfrmConfiguracoesLazzumixLinhas.pAdicionar;
begin
  pMover(lsbDisponiveis, lsbUtilizadas);
end;

procedure TfrmConfiguracoesLazzumixLinhas.pAdicionarTudo;
  Var
    intContador: Integer;
begin
  For intContador := 0 To lsbDisponiveis.Count-1 Do
  Begin
    lsbDisponiveis.ItemIndex := 0;
    pAdicionar;
  End;
end;

procedure TfrmConfiguracoesLazzumixLinhas.pMover(lsbOrigem,
  lsbDestino: TListBox);
  Var
    intIndiceOri: Integer;
begin
  If (lsbOrigem.ItemIndex >= 0) Then
  Begin
    intIndiceOri := lsbOrigem.ItemIndex;
    lsbDestino.Items.Add(lsbOrigem.Items[lsbOrigem.ItemIndex]);
    lsbOrigem.Items.Delete(lsbOrigem.ItemIndex);
    If lsbOrigem.Count > 0 Then
      lsbOrigem.ItemIndex := intIndiceOri;
  End;

  pOrdenarListas;
end;

procedure TfrmConfiguracoesLazzumixLinhas.pOrdenarListas;
begin
  lsbDisponiveis.Sorted := True;
  lsbUtilizadas.Sorted := True;
end;

procedure TfrmConfiguracoesLazzumixLinhas.pPreencherListas;
  Var
    stlJaUtilizadas: TStringList;
    strChave: String;
begin
  stlJaUtilizadas := TStringList.Create;
  stlJaUtilizadas.Delimiter := ';';
  stlJaUtilizadas.DelimitedText := strConfigAtual;
  FQryLinhas.First;

  While Not FQryLinhas.Eof Do
  Begin
    strChave := FQryLinhas.FieldByName('MIX_REFERE').AsString;

    If Pos(strChave, strConfigAtual) > 0 Then
      lsbUtilizadas.Items.Add(strChave)
    Else
      lsbDisponiveis.Items.Add(strChave);

    FQryLinhas.Next;
  End;

  pOrdenarListas;
end;

procedure TfrmConfiguracoesLazzumixLinhas.pRemover;
begin
  pMover(lsbUtilizadas, lsbDisponiveis);
end;

procedure TfrmConfiguracoesLazzumixLinhas.pRemoverTudo;
  Var
    intContador: Integer;
begin
  For intContador := 0 To lsbUtilizadas.Count-1 Do
  Begin
    lsbUtilizadas.ItemIndex := 0;
    pRemover;
  End;
end;

{function TfrmConfiguracoesLazzumixLinhas.fRetornaCodigoLinha(strLinhaBusca: String): String;
begin
  Result := dicLinhas[strLinhaBusca];
end;}

end.
