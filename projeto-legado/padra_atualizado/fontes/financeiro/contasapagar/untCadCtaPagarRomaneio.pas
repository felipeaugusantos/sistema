unit untCadCtaPagarRomaneio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, System.Generics.Collections,
  Aurelius.Bind.Dataset, UntTCadPagRomaneio,
  UntTCadPagRomaneioRepository, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  untTRomaneioRepository, untTypesSistema;

type
  TfrmCadCtaPagarRomaneio = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtNumRom: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnInserir: TBitBtnLocked;
    pnlBotoesDesm: TPanel;
    dtsDados: TDataSource;
    grdDados: TcxGridCitel;
    grdDadosDados: TcxGridDBTableViewCitel;
    grdDadosNivel: TcxGridLevel;
    grdDadosDadosRomaneio: TcxGridDBColumn;
    grdDadosDadosEmpresa: TcxGridDBColumn;
    grdDadosDadosVeiculo: TcxGridDBColumn;
    grdDadosDadosMotorista: TcxGridDBColumn;
    grdDadosDadosNumeroRomaneio: TcxGridDBColumn;
    btnGravar: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    Label2: TLabel;
    grdDadosDadosNumeroDocumento: TcxGridDBColumn;
    edtNumeroDocumento: TEditFocus;
    lblRomaneio: TLabel;
    lblDescRomaneio: TLabel;
    lblDescDocumento: TLabel;
    Label3: TLabel;
    btnLimparFiltro: TBitBtnLocked;
    procedure edtNumRomKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdDadosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNumeroDocumentoExit(Sender: TObject);
    procedure edtNumRomExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnLimparFiltroClick(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    FCodigoFornecedor       : string;
    FCodigoEmpresa          : String;
    FNumeroDuplicata        : string;
    FSerie                  : string;

    FCadPagRomaneioRepository : TCadPagRomaneioRepository;
    FRomaneioRepository       : TRomaneioRepository;

    FListaCadPagRomaneio         : TList<TCadPagRomaneio>;
    FListaCadPagRomaneioApagados : TList<TCadPagRomaneio>;
    FcdsCadPagRomaneio           : TAureliusDataset;

    arrSel : TConsultasArray;

    procedure CarregarGrid;
    procedure AtualizaCampos;
  public
    { Public declarations }
    property CodigoFornecedor : string Read FCodigoFornecedor  Write FCodigoFornecedor;
    property CodigoEmpresa    : String Read FCodigoEmpresa     Write FCodigoEmpresa;
    property NumeroDuplicata  : string Read FNumeroDuplicata   Write FNumeroDuplicata;
    property Serie            : string Read FSerie             Write FSerie;
  end;

implementation

uses untFuncoesSimples, untConsultas, Uni, untPesqAux, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadCtaPagarRomaneio.AtualizaCampos;
begin
  if Length(arrSel) > 1 then
  begin
    edtNumRom.Enabled := False;

    edtNumeroDocumento.Text    := fStrZero('0',12);
    edtNumeroDocumento.Enabled := False;

    edtCodEmp.Text             := fStrZero('0',3);
    edtCodEmp.Enabled          := False;

    lblDescDocumento.Visible   := True;
    lblDescRomaneio.Visible    := True;

    lblDescRomaneio.Caption    := '+1';
    lblDescDocumento.Caption   := '+1';
    edtNomEmp.Text             := '+1';

    pSetFocus(btnInserir);
  end
  else
  begin
    lblDescRomaneio.Visible    := False;

    edtNumRom.Enabled          := True;
    edtNumeroDocumento.Enabled := True;
    edtCodEmp.Enabled          := True;

    if (not fEmptyStr(edtNumRom.text)) and (fEmptyStr(edtNumeroDocumento.text)) then
    begin
      lblDescDocumento.Visible := True;
      lblDescDocumento.Caption := 'TODOS';
    end
    else
      lblDescDocumento.Visible := False;
  end;
end;

procedure TfrmCadCtaPagarRomaneio.btnGravarClick(Sender: TObject);
begin
  fStartTransaction;
  try
    FCadPagRomaneioRepository.pDeletar(FListaCadPagRomaneioApagados);
    FCadPagRomaneioRepository.pGravar(FListaCadPagRomaneio);
    fCommit;

    fMensagem('', 'Despesa atualizada com sucesso!', ['&OK']);

    pSetFocus(edtNumRom);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnConfirmaClick]');
    End;
  end;

  Close;
end;

procedure TfrmCadCtaPagarRomaneio.btnInserirClick(Sender: TObject);
var SQuery : TUniQuery;
    SRomaneio : String;
begin
  if (not fValidaCampos(edtCodEmp)) then
    Exit;
  if (not fValidaCampos(edtNumRom)) then
    Exit;

  FcdsCadPagRomaneio.DisableControls;

  SQuery := fCriaQuery;
  try
    SQuery.SQL.Text := ' SELECT AUTOINCREM '+
                       '   FROM ROMGERX '+
                       '  WHERE ';

    if Length(arrSel) > 1 then
    begin
      SQuery.SQL.Add(fStrLocate(edtNumRom, arrSel, 'AUTOINCREM', 'AUTOINCREM', True));
      pSetaParam(edtNumRom.Text, arrSel, SRomaneio, 'AUTOINCREM', SQuery);
    end
    else
    begin
      SQuery.SQL.Add(' GER_NUMROM = :NUMROM AND '+
                     ' GER_CODEMP = :CODEMP ');

      if not fEmptyStr(edtNumeroDocumento.Text) then
      begin
        SQuery.SQL.Add(' AND GER_NUMDOC = :NUMDOC ');
        SQuery.ParamByName('NUMDOC').AsString := edtNumeroDocumento.text;
      end;

      SQuery.ParamByName('CODEMP').AsString := edtCodEmp.text;
      SQuery.ParamByName('NUMROM').AsString := edtNumRom.text;
    end;

    SQuery.Open;

    if SQuery.IsEmpty then
    begin
      SQuery.Close;
      fMensagem('ATENÇÃO!', 'Não foram encontrados documentos relacionados a este romaneio!', ['&Ok']);
      FcdsCadPagRomaneio.EnableControls;
      pSetFocus(edtNumRom);
      Exit;
    end;

    while not SQuery.Eof do
    begin
      if FcdsCadPagRomaneio.Locate('Romaneio.AutoIncremento', SQuery.FieldByName('AUTOINCREM').AsString, []) then
      begin
        SQuery.Next;
        continue;
      end;

      FRomaneioRepository.Selecionado := FRomaneioRepository.fGetRomaneio(SQuery.FieldByName('AUTOINCREM').AsString);

      try
        if Assigned(FRomaneioRepository.Selecionado) then
        begin
          FcdsCadPagRomaneio.Append;
          FcdsCadPagRomaneio.Current<TCadPagRomaneio>.NumeroDuplicata  := FNumeroDuplicata;
          FcdsCadPagRomaneio.Current<TCadPagRomaneio>.Serie            := FSerie;
          FcdsCadPagRomaneio.Current<TCadPagRomaneio>.CodigoFornecedor := FCodigoFornecedor;
          FcdsCadPagRomaneio.Current<TCadPagRomaneio>.CodigoEmpresa    := FCodigoEmpresa;
          FcdsCadPagRomaneio.Current<TCadPagRomaneio>.Romaneio         := FRomaneioRepository.Selecionado;
          FcdsCadPagRomaneio.Post;
        end;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[btnInserirClick]');
        End;
      end;

      SQuery.Next;
    end;

    SQuery.Close;

  finally
    FreeAndNil(SQuery);
  end;

  FcdsCadPagRomaneio.EnableControls;

  btnLimparFiltro.Click;
end;

procedure TfrmCadCtaPagarRomaneio.btnLimparFiltroClick(Sender: TObject);
begin
  edtNumRom.Clear;
  SetLength(arrSel, 0);
  edtNumeroDocumento.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.text := fRetNomeEmpresa(edtCodEmp.Text);
  AtualizaCampos;
  pSetFocus(edtNumRom);
end;

procedure TfrmCadCtaPagarRomaneio.CarregarGrid;
begin
  FListaCadPagRomaneio := FCadPagRomaneioRepository.fGetContasPagarVinculadasComRomaneio(FNumeroDuplicata,
    FSerie, FCodigoFornecedor, FCodigoEmpresa);

  FcdsCadPagRomaneio.SetSourceList(FListaCadPagRomaneio);
  FcdsCadPagRomaneio.Open;

  dtsDados.DataSet := FcdsCadPagRomaneio;
end;

procedure TfrmCadCtaPagarRomaneio.edtCodEmpExit(Sender: TObject);
begin
  AtualizaCampos;
end;

procedure TfrmCadCtaPagarRomaneio.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaPagarRomaneio.edtNumeroDocumentoExit(Sender: TObject);
begin
  AtualizaCampos;
end;

procedure TfrmCadCtaPagarRomaneio.edtNumRomExit(Sender: TObject);
begin
  if (fEmptyStr(edtNumRom.Text)) or (edtNumRom.Text <> fStrZero('0', 8)) then
    SetLength(arrSel,0);
  AtualizaCampos;
end;

procedure TfrmCadCtaPagarRomaneio.edtNumRomKeyPress(Sender: TObject; var Key: Char);
Var qryConGen : TUniQuery;
begin
  qryConGen := fCriaQuery(Self);
  try
    If fPesqRomaneio(Self, edtNumRom, qryConGen, Key, arrSel, '', False, True, 'Consulta de Romaneios') Then
    Begin
      if Length(arrSel) = 1 then
      begin
        edtCodEmp.Text := qryConGen.FieldByName('GER_CODEMP').AsString;
        fValidaCampos(edtCodEmp, True);

        edtNumeroDocumento.Text  := qryConGen.FieldByName('GER_NUMDOC').AsString;
      end;

      If (fValidaCampos(edtNumRom, True)) Then
        SelectNext(ActiveControl, True, True);

      AtualizaCampos;
    End;
  finally
    FreeAndNil(qryConGen);
  end;
end;

procedure TfrmCadCtaPagarRomaneio.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListaCadPagRomaneioApagados);
  FreeAndNil(FCadPagRomaneioRepository);
  FreeAndNil(FRomaneioRepository);
  inherited;
end;

procedure TfrmCadCtaPagarRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_F10) Then
    btnGravar.Click;

  If (Key = VK_F4) Then
    btnLimparFiltro.Click;
end;

procedure TfrmCadCtaPagarRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.text := fRetNomeEmpresa(edtCodEmp.Text);

  CarregarGrid;

  pSetFocus(edtNumRom);
end;

function TfrmCadCtaPagarRomaneio.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var SQuery : TUniQuery;
begin
  Result := True;

  if length(arrSel) > 1 then
    Exit;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNumRom) Then
    Begin
      If (Not fEmptyStr(edtNumRom.Text)) Then
      Begin
        SQuery := fCriaQuery(Self);
        try
          SQuery.SQL.Text := 'SELECT AUTOINCREM '+
                             '  FROM ROMGERX '+
                             ' WHERE GER_NUMROM = :NUMROM '+
                             '   AND GER_CODEMP = :EMPROM ';
          SQuery.ParamByName('NUMROM').AsString := edtNumRom.Text;
          SQuery.ParamByName('EMPROM').AsString := edtCodEmp.Text;
          SQuery.Open;
          if SQuery.IsEmpty Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse romaneio não está cadastrado ou não pertence a esta empresa!', ['&Ok']);
            pSetFocus(edtNumRom);
            Exit(False);
          End;
          SQuery.Close;
        finally
          FreeAndNil(SQuery);
        end;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O romaneio deve ser preechido!', ['&Ok']);
        pSetFocus(edtNumRom);
        Exit(False);
      End;
    End

    else If (Sender = edtCodEmp) then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        pSetFocus(edtCodEmp);
        Exit(False);
      End
      Else
      Begin
        SQuery := fCriaQuery(Self);
        try
          pPesquisaCadEmp(SQuery, SQuery, edtCodEmp.Text);
          edtNomEmp.Text := SQuery.FieldByName('EMP_NOMEMP').AsString;
          If SQuery.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            pSetFocus(edtCodEmp);
            Exit(False);
          End;
        finally
          FreeAndNil(SQuery);
        end;
      End;
    End;

  End;
end;

procedure TfrmCadCtaPagarRomaneio.grdDadosDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Delete) And (Not FcdsCadPagRomaneio.IsEmpty) Then
  Begin
    If (FcdsCadPagRomaneio.RecordCount > 0) And
       (fMensagem('', 'Confirma exclusão do romaneio?', ['&Sim', '&Não']) = 1) Then
    Begin
      if not fEmptyStr(FcdsCadPagRomaneio.Current<TCadPagRomaneio>.AutoIncremento) then
        FListaCadPagRomaneioApagados.Add(FcdsCadPagRomaneio.Current<TCadPagRomaneio>);
      FcdsCadPagRomaneio.Delete;
      FcdsCadPagRomaneio.First;
    End;
  End;
end;

procedure TfrmCadCtaPagarRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  FCadPagRomaneioRepository := TCadPagRomaneioRepository.Create;
  FRomaneioRepository       := TRomaneioRepository.Create;

  FListaCadPagRomaneioApagados := TList<TCadPagRomaneio>.Create;

  FcdsCadPagRomaneio := TAureliusDataset.Create(Owner);

  with TStringField.Create(Self) do
  begin
    FieldName := 'Romaneio.NumeroRomaneio';
    Dataset := FcdsCadPagRomaneio;
  end;

  with TStringField.Create(Self) do
  begin
    FieldName := 'Romaneio.NumeroDocumento';
    Dataset := FcdsCadPagRomaneio;
  end;

  with TStringField.Create(Self) do
  begin
    FieldName := 'Romaneio.AutoIncremento';
    Dataset := FcdsCadPagRomaneio;
  end;  with TStringField.Create(Self) do  begin
    FieldName := 'Romaneio.EmpresaRomaneio';
    Dataset := FcdsCadPagRomaneio;
  end;  with TStringField.Create(Self) do  begin
    FieldName := 'Romaneio.PlacaVeiculo';
    Dataset := FcdsCadPagRomaneio;
  end;  with TStringField.Create(Self) do  begin
    FieldName := 'Romaneio.Motorista.Descricao';
    Dataset := FcdsCadPagRomaneio;
  end;end;

end.
