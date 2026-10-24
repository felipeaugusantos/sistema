unit untConfiguracoesWandaProLinhas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, BitBtnLockedIncrem;

type
  TfrmConfiguracoesWandaProLinhas = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure lsbDisponiveisDblClick(Sender: TObject);
    procedure lsbUtilizadasDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
//    dicLinhas: TDicionario;

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

Type
  TNomes = Record
    strNomes: String;
End;

type
  TArrNomes = Array Of TNomes;
{= ('Autobase Plus 100:50', 'Wandabase HS', 'Wandalac',
                                   'Wandacar', 'Single Stage Converter',
                                   'Autocoat BT100', 'Autobase Plus 100:80',
                                   'Autocoat BT120', 'Wanda PU HS', 'Wanda PU MS',
                                   'Autocoat BT90', 'Autocoat BT110',
                                   'Autocoat BT130', 'Autowave MM', 'Autowave MM 2.0', 'Tech Fleet PU')}
type
  TArrNumeros = Array Of TArrNomes;
{ = ('001', '004', '006', '009', '011', '013',
                                       '014', '016', '008', '058', '059', '015',
                                       '017', '027', '067', '072');}

  ArrNomes   = TArrNomes;
  ArrNumeros = TArrNumeros;


const
  arrTintas: array[1..21] of array[1..2] of string = (
                                   ('Autobase Plus 100:50',   '001'),
                                   ('Wandabase HS',           '004'),
                                   ('Wandalac',               '006'),
                                   ('Wandacar',               '009'),
                                   ('Single Stage Converter', '011'),
                                   ('Autocoat BT100',         '013'),
                                   ('Autobase Plus 100:80',   '014'),
                                   ('Autocoat BT120',         '016'),
                                   ('Wanda PU HS',            '008'),
                                   ('Wanda PU MS',            '058'),
                                   ('Autocoat BT90',          '059'),
                                   ('Autocoat BT110',         '015'),
                                   ('Autocoat BT130',         '017'),
                                   ('Autowave MM',            '027'),
                                   ('Autowave MM 2.0',        '067'),
                                   ('Tech Fleet PU',          '072'),
                                   ('Tech Fleet Epoxy',       '074'),
                                   ('Tech Fleet Sintetico',   '075'),
                                   ('Tech Fleet Laca',        '076'),
                                   ('Autobase Plus Baseline 100:80', '012'),
                                   ('Autobase Plus Baseline 100:50', '019'));

var
  frmConfiguracoesWandaProLinhas: TfrmConfiguracoesWandaProLinhas;

implementation

{$R *.dfm}

{ TfrmConfiguracoesWandaProLinhas }

procedure TfrmConfiguracoesWandaProLinhas.btnAdicionarClick(Sender: TObject);
begin
  pAdicionar;
end;

procedure TfrmConfiguracoesWandaProLinhas.btnAdicionarTodosClick(
  Sender: TObject);
begin
  pAdicionarTudo;
end;

procedure TfrmConfiguracoesWandaProLinhas.btnGravarConfClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmConfiguracoesWandaProLinhas.btnRemoverClick(Sender: TObject);
begin
  pRemover;
end;

procedure TfrmConfiguracoesWandaProLinhas.btnRemoverTodosClick(Sender: TObject);
begin
  pRemoverTudo;
end;

procedure TfrmConfiguracoesWandaProLinhas.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracoesWandaProLinhas.FormCreate(Sender: TObject);
begin
{
  dicLinhas := TDicionario.Create;

  dicLinhas['Autobase Plus 100:50']   := '001';
  dicLinhas['Wandabase HS']           := '004';
  dicLinhas['Wandalac']               := '006';
  dicLinhas['Wandacar']               := '009';
  dicLinhas['Single Stage Converter'] := '011';
  dicLinhas['Autocoat BT100']         := '013';
  dicLinhas['Autobase Plus 100:80']   := '014';
  dicLinhas['Autocoat BT120']         := '016';
  dicLinhas['Wanda PU HS']            := '008';
  dicLinhas['Wanda PU MS']            := '058';
  dicLinhas['Autocoat BT90']          := '059';
  dicLinhas['Autocoat BT110']         := '015';
  dicLinhas['Autocoat BT130']         := '017';
  dicLinhas['Autowave MM']            := '027';
  dicLinhas['Autowave MM 2.0']        := '067';
  dicLinhas['Tech Fleet PU']          := '072';
}
end;

procedure TfrmConfiguracoesWandaProLinhas.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(dicLinhas);
end;

procedure TfrmConfiguracoesWandaProLinhas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmConfiguracoesWandaProLinhas.FormShow(Sender: TObject);
begin
  pPreencherListas;
end;

function TfrmConfiguracoesWandaProLinhas.getLinhasUtilizadas: String;
  Var
    intContador: Integer;
    strLinha: String;
    intCont: Integer;
begin
  Result := '';
  strLinha := '';

  For intContador := 0 To lsbUtilizadas.Count - 1 Do
  Begin

    strLinha := lsbUtilizadas.Items[intContador]; //dicLinhas[lsbUtilizadas.Items[intContador]];

    For intCont := 1 To Length(arrTintas) Do
    Begin
      If strLinha = (arrTintas[intCont][1]) Then
      Begin
        Result := Result + (arrTintas[intCont][2]);
        Break;
      End;
    End;
  End;
end;

procedure TfrmConfiguracoesWandaProLinhas.lsbDisponiveisDblClick(
  Sender: TObject);
begin
  pAdicionar;
end;

procedure TfrmConfiguracoesWandaProLinhas.lsbUtilizadasDblClick(
  Sender: TObject);
begin
  pRemover;
end;

procedure TfrmConfiguracoesWandaProLinhas.pAdicionar;
begin
  pMover(lsbDisponiveis, lsbUtilizadas);
end;

procedure TfrmConfiguracoesWandaProLinhas.pAdicionarTudo;
  Var
    intContador: Integer;
begin
  For intContador := 0 To lsbDisponiveis.Count-1 Do
  Begin
    lsbDisponiveis.ItemIndex := 0;
    pAdicionar;
  End;
end;

procedure TfrmConfiguracoesWandaProLinhas.pMover(lsbOrigem,
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

procedure TfrmConfiguracoesWandaProLinhas.pOrdenarListas;
begin
  lsbDisponiveis.Sorted := True;
  lsbUtilizadas.Sorted := True;
end;

procedure TfrmConfiguracoesWandaProLinhas.pPreencherListas;
  Var
    stlJaUtilizadas: TStringList;
    strChave: String;
    strLinha: String;
    intContador: Integer;
begin
  stlJaUtilizadas := TStringList.Create;
  stlJaUtilizadas.Delimiter := '_';
  stlJaUtilizadas.DelimitedText := strConfigAtual;

  For intContador := 1 To Length(arrTintas) Do  //dicLinhas.Chaves.Count-1
  Begin
    strChave := (arrTintas[intContador][1]); // dicLinhas.Chaves[intContador];
    strLinha := (arrTintas[intContador][2]); // fRetornaCodigoLinha(strChave);
    If stlJaUtilizadas.IndexOf(strLinha) >= 0 Then
      lsbUtilizadas.Items.Add(strChave)
    Else
      lsbDisponiveis.Items.Add(strChave);
  End;

  pOrdenarListas;

end;

procedure TfrmConfiguracoesWandaProLinhas.pRemover;
begin
  pMover(lsbUtilizadas, lsbDisponiveis);
end;

procedure TfrmConfiguracoesWandaProLinhas.pRemoverTudo;
  Var
    intContador: Integer;
begin
  For intContador := 0 To lsbUtilizadas.Count-1 Do
  Begin
    lsbUtilizadas.ItemIndex := 0;
    pRemover;
  End;
end;

{function TfrmConfiguracoesWandaProLinhas.fRetornaCodigoLinha(strLinhaBusca: String): String;
begin
  Result := dicLinhas[strLinhaBusca];
end;}

end.
