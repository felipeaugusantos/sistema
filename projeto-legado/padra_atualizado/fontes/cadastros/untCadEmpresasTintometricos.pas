unit untCadEmpresasTintometricos;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmpresasTintometricos = class(TfrmPai)
    pnlDisponiveis: TPanel;
    lsbDisponiveis: TListBox;
    Label1: TLabel;
    Panel2: TPanel;
    pnlUtilizadas: TPanel;
    Label2: TLabel;
    lsbUtilizadas: TListBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    btnAddUm: TSpeedButton;
    btnAddTodos: TSpeedButton;
    btnDelUma: TSpeedButton;
    btnDelTodos: TSpeedButton;
    btnConfirmar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnAddUmClick(Sender: TObject);
    procedure btnDelUmaClick(Sender: TObject);
    procedure btnAddTodosClick(Sender: TObject);
    procedure btnDelTodosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure lsbDisponiveisDblClick(Sender: TObject);
    procedure lsbUtilizadasDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    stlSiglas: TStringList;
    procedure pInicializaListas;

    procedure pAddUma(blnApagar: Boolean);
    procedure pDelUma(blnApagar: Boolean);
  public
    { Public declarations }
    strTintas: String;
  end;


implementation

uses Forms, untITintasDeMaquina, untFuncTinta, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadEmpresasTintometricos }

procedure TfrmCadEmpresasTintometricos.pInicializaListas;
  Var
    iTintas: ITintasDeMaquina;
    intContador: Integer;
begin
  iTintas := fGetTintasdeMaquina;

  For intContador := 0 To iTintas.fGetQtdTintas - 1 Do
  Begin

    If Pos(iTintas.fGetIdePro(intContador), strTintas) > 0 Then
      lsbUtilizadas.Items.Add(iTintas.fGetNomeTinta(intContador))
    Else
    begin
      if (iTintas.fGetNomeTinta(intContador) <> '') then
        lsbDisponiveis.Items.Add(iTintas.fGetNomeTinta(intContador));
    end;
      
  End;

  If lsbDisponiveis.Count > 0  Then
  Begin
    pSetFocus(lsbDisponiveis);
    lsbDisponiveis.ItemIndex := 0;
  End
  Else
  Begin
    pSetFocus(lsbUtilizadas);
    lsbUtilizadas.ItemIndex := 0;
  End;

end;

procedure TfrmCadEmpresasTintometricos.FormCreate(Sender: TObject);
begin
  inherited;
  stlSiglas := TStringList.Create;
end;

procedure TfrmCadEmpresasTintometricos.btnAddUmClick(Sender: TObject);
begin
  inherited;
  pAddUma(True);
end;

procedure TfrmCadEmpresasTintometricos.pAddUma(blnApagar: Boolean);
  Var
    intIndex: Integer;
begin

  If lsbDisponiveis.Count <= 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhuma tinta disponível para adicionar.', ['&Ok']);
    Exit;
  End;

  If lsbDisponiveis.ItemIndex < 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione uma tinta para adicionar.', ['&Ok']);
    Exit;
  End;

  lsbUtilizadas.Items.Add(lsbDisponiveis.Items[lsbDisponiveis.ItemIndex]);

  If (blnApagar) Then
  Begin
    intIndex := lsbDisponiveis.ItemIndex;
    lsbDisponiveis.DeleteSelected;
    If lsbDisponiveis.Count-1 >= intIndex Then
    Begin
      Try
        lsbDisponiveis.ItemIndex := intIndex;
      Except
        lsbDisponiveis.ItemIndex := 0;
      End;
    End
    Else If lsbDisponiveis.Count > 0 Then
    Begin
      lsbDisponiveis.ItemIndex := lsbDisponiveis.Count -1;
    End;
  End;

end;

procedure TfrmCadEmpresasTintometricos.pDelUma(blnApagar: Boolean);
  Var
    intIndex: Integer;
begin
  If lsbUtilizadas.Count <= 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhuma tinta disponível para remover.', ['&Ok']);
    Exit;
  End;

  If lsbUtilizadas.ItemIndex < 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione uma tinta para remover.', ['&Ok']);
    Exit;
  End;

  lsbDisponiveis.Items.Add(lsbUtilizadas.Items[lsbUtilizadas.ItemIndex]);

  If (blnApagar) Then
  Begin
    intIndex := lsbUtilizadas.ItemIndex;
    lsbUtilizadas.DeleteSelected;
    If lsbUtilizadas.Count-1 >= intIndex Then
    Begin
      Try
        lsbUtilizadas.ItemIndex := intIndex;
      Except
        lsbUtilizadas.ItemIndex := 0;
      End;
    End
    Else If lsbUtilizadas.Count > 0 Then
    Begin
      lsbUtilizadas.ItemIndex := lsbUtilizadas.Count -1;
    End;
  End;
end;

procedure TfrmCadEmpresasTintometricos.btnDelUmaClick(Sender: TObject);
begin
  inherited;
  pDelUma(True);
end;

procedure TfrmCadEmpresasTintometricos.btnAddTodosClick(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  For intContador := 0 To lsbDisponiveis.Count -1 Do
  Begin
    lsbDisponiveis.ItemIndex := intContador;
    pAddUma(False);
  End;

  lsbDisponiveis.Clear;
end;

procedure TfrmCadEmpresasTintometricos.btnDelTodosClick(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  For intContador := 0 To lsbUtilizadas.Count -1 Do
  Begin
    lsbUtilizadas.ItemIndex := intContador;
    pDelUma(False);
  End;

  lsbUtilizadas.Clear;
end;

procedure TfrmCadEmpresasTintometricos.btnConfirmarClick(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  strTintas := '';
  For intContador := 0 To lsbUtilizadas.Count -1 Do
  Begin
    strTintas := strTintas + fRetornaSiglaTinta(lsbUtilizadas.Items[intContador]) + '_';
  End;
  ModalResult := mrOk;
end;

procedure TfrmCadEmpresasTintometricos.lsbDisponiveisDblClick(
  Sender: TObject);
begin
  inherited;
  btnAddUm.Click;
end;

procedure TfrmCadEmpresasTintometricos.lsbUtilizadasDblClick(
  Sender: TObject);
begin
  inherited;
  btnDelUma.Click;
end;

procedure TfrmCadEmpresasTintometricos.FormShow(Sender: TObject);
begin
  inherited;
  pInicializaListas;
end;

end.
