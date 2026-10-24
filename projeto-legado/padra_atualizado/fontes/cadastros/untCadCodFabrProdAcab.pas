unit untCadCodFabrProdAcab;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  DBCtrls, UniClientDataSet, Uni, EditFocus, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

Type
  TIndMenus = Record
    strDescricao: String;
    strTabelaCampo: String;
    strExpressao: String;    
End;

type
  TfrmCadCodFabrProdAcab = class(TfrmPai)
    pnlGeral: TPanel;
    pnlEsquerda: TPanel;
    pnlCentro: TPanel;
    pnlDireita: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    pnlLegEsq: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnAddUm: TSpeedButton;
    btnAddTodos: TSpeedButton;
    btnDelTodos: TSpeedButton;
    btnDelUma: TSpeedButton;
    dbgEsquerdaDBTableView1: TcxGridDBTableView;
    dbgEsquerdaLevel1: TcxGridLevel;
    dbgEsquerda: TcxGrid;
    dbgDireitaDBTableView1: TcxGridDBTableView;
    dbgDireitaLevel1: TcxGridLevel;
    dbgDireita: TcxGrid;
    dtsEsquerda: TDataSource;
    dtsDireita: TDataSource;
    cdsEsquerda: TUniClientDataSet;
    cdsDireita: TUniClientDataSet;
    cdsEsquerdaDescricaoCampo: TStringField;
    cdsDireitaDescricaoCampo: TStringField;
    dbgEsquerdaDBTableView1DescricaoCampo: TcxGridDBColumn;
    dbgEsquerdaDBTableView1TabelaCampo: TcxGridDBColumn;
    dbgDireitaDBTableView1DescricaoCampo: TcxGridDBColumn;
    dbgDireitaDBTableView1TabelaCampo: TcxGridDBColumn;
    cdsEsquerdaSequencia: TIntegerField;
    dbgEsquerdaDBTableView1Sequencia: TcxGridDBColumn;
    edtExpressao: TEditFocus;
    cdsEsquerdaTabelaCampo: TStringField;
    cdsDireitaTabelaCampo: TStringField;
    btnConfirma: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDelUmaClick(Sender: TObject);
    procedure btnAddUmClick(Sender: TObject);
    procedure btnAddTodosClick(Sender: TObject);
    procedure btnDelTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgEsquerdaDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgEsquerdaDBTableView1DblClick(Sender: TObject);
    procedure cdsEsquerdaAfterScroll(DataSet: TDataSet);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    arrDireita  : Array Of TIndMenus;
    arrEsquerda : Array Of TIndMenus;
    procedure pCarregaCdsDireita;
    procedure pCarregaCdsEsquerda;
    procedure pLendoCamposDireita(strCampos: String);
    procedure pLendoCamposEsquerda(strCampos: String);
    procedure pAdicionarCdsDireita;
    procedure pAdicionarCdsEsquerda;
    procedure pAtualizaGridEsquerda;
    procedure pInserirNaEsquerda;
    procedure pExcluirDaDireita;
    procedure pAtualizaGridDireita;
    procedure pInserirNaDireita;
    procedure pExcluirDaEsquerda;
    procedure pAtualizaGridDireitaTodos;
    procedure pInserirNaDireitaTodos;
    procedure pAtualizaGridEsquedaTodos;
    procedure pInserirNaEsquerdaTodos;
    procedure pAtualizaCfgSisCodigoFabricaProdutoAcabado;
    procedure pMudaOrdemParaCima;
    procedure pMudaOrdemParaBaixo;

    function fRetornaCamposDireita: String;
    function fRetornaCamposEsquerda: String;
    function fCountCamposDireita(strCampos: String; strSeparador: String): Integer;
    function fCountCamposEsquerda(strCampos: String; strSeparador: String): Integer;
    function fRetornaSQLUpdateCfgSis: String;
    function fRetornaSQLConsultaCfgSis: String;
    function fRetornaStringCampos: String;
    function fRetornaSequenciaGridEsquerda: Integer;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCodFabrProdAcab.btnAddTodosClick(Sender: TObject);
begin
  inherited;
  pAtualizaGridDireitaTodos;
end;

procedure TfrmCadCodFabrProdAcab.btnAddUmClick(Sender: TObject);
begin
  inherited;
  pAtualizaGridDireita;
end;

procedure TfrmCadCodFabrProdAcab.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pAtualizaCfgSisCodigoFabricaProdutoAcabado;
end;

procedure TfrmCadCodFabrProdAcab.btnDelTodosClick(Sender: TObject);
begin
  inherited;
  pAtualizaGridEsquedaTodos;
end;

procedure TfrmCadCodFabrProdAcab.btnDelUmaClick(Sender: TObject);
begin
  inherited;
  pAtualizaGridEsquerda;
end;

procedure TfrmCadCodFabrProdAcab.btnGravarClick(Sender: TObject);
begin
  inherited;
  Try
    With cdsEsquerda Do
    Begin
      If Not fEmptyStr(edtExpressao.Text) Then
      Begin
        Edit;
        FieldByName('Expressao').AsString := edtExpressao.Text;
        Post;

        fMensagem('Informação!','Expressão gravada com sucesso !',['&OK']);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadCodFabrProdAcab.cdsEsquerdaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtExpressao.Enabled := False;
  btnGravar.Enabled    := False;
  edtExpressao.Clear;
end;

procedure TfrmCadCodFabrProdAcab.dbgEsquerdaDBTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  edtExpressao.Enabled := True;
  btnGravar.Enabled    := True;
  With cdsEsquerda Do
  Begin
    If fEmptyStr(FieldByName('Expressao').AsString) Then
      edtExpressao.Text := FieldByName('TabelaCampo').AsString
    Else
      edtExpressao.Text := FieldByName('Expressao').AsString;
  End;
end;

procedure TfrmCadCodFabrProdAcab.dbgEsquerdaDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F1: pMudaOrdemParaCima;
    VK_F2: pMudaOrdemParaBaixo;
  End;
end;

function TfrmCadCodFabrProdAcab.fCountCamposDireita(strCampos: String; strSeparador: String): Integer;
var
  intCont: Integer;
begin
  Result    := 0;
  Try
    intCont   := Result;
    If Not fEmptyStr(strCampos) Then
    Begin
      While Not fEmptyStr(strCampos) Do
      Begin
        If (Pos(strSeparador, strCampos) > 0) Then
          strCampos := Trim(Copy(strCampos,Pos(strSeparador,strCampos) + 2,Length(strCampos)))
        Else
          strCampos := '';
        inc(intCont);
      End;
      Result := intCont;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCountCampos]');
    End;
  End;
end;

function TfrmCadCodFabrProdAcab.fCountCamposEsquerda(strCampos: String; strSeparador: String): Integer;
var
  intCont: Integer;
begin
  Result    := 0;
  Try
    intCont   := Result;
    If Not fEmptyStr(strCampos) Then
    Begin
      While Not fEmptyStr(strCampos) Do
      Begin
        If (Pos(strSeparador, strCampos) > 0) Then
          strCampos := Trim(Copy(strCampos,Pos(strSeparador,strCampos) + 1,Length(strCampos)))
        Else
          strCampos := '';
        inc(intCont);
      End;
      Result := intCont;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCountCampos]');
    End;
  End;
end;


procedure TfrmCadCodFabrProdAcab.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsDireita.EmptyDataSet;
  cdsEsquerda.EmptyDataSet;
end;

procedure TfrmCadCodFabrProdAcab.FormCreate(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := True;
end;

procedure TfrmCadCodFabrProdAcab.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmCadCodFabrProdAcab.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaCdsEsquerda;
  pCarregaCdsDireita;
  pSetFocus(btnConfirma);
end;

procedure TfrmCadCodFabrProdAcab.pAdicionarCdsDireita;
var
  intCont: Integer;
begin
  With cdsDireita Do
  Begin
    CreateDataSet;
    For intCont := 0 To Length(arrDireita) - 1 Do
    Begin
      If Not cdsEsquerda.Locate('TabelaCampo',arrDireita[intCont].strTabelaCampo,[]) Then
      Begin
        Append;
        FieldByName('DescricaoCampo').AsString := arrDireita[intCont].strDescricao;
        FieldByName('TabelaCampo').AsString    := arrDireita[intCont].strTabelaCampo;
        Post;
      End
      Else
      Begin
        cdsEsquerda.Edit;
        cdsEsquerda.FieldByName('DescricaoCampo').AsString := arrDireita[intCont].strDescricao;
        cdsEsquerda.Post;
      End;
    End;
    cdsDireita.IndexFieldNames := 'DescricaoCampo';
    cdsDireita.First;
    pSetFocus(dbgDireita);
    SetLength(arrDireita,0);
  End;
end;

procedure TfrmCadCodFabrProdAcab.pAdicionarCdsEsquerda;
var
  intCont: Integer;
begin
  With cdsEsquerda Do
  Begin
    For intCont := 0 To Length(arrEsquerda) - 1 Do
    Begin
      Append;
      FieldByName('TabelaCampo').AsString := arrEsquerda[intCont].strTabelaCampo;
      FieldByName('Sequencia').AsInteger  := intCont;
      FieldByName('Expressao').AsString   := arrEsquerda[intCont].strExpressao;
      Post;
    End;
    SetLength(arrEsquerda,0);
  End;
end;

procedure TfrmCadCodFabrProdAcab.pAtualizaCfgSisCodigoFabricaProdutoAcabado;
var
  qryUpd: TUniQuery;
begin
  Try
    Try
      qryUpd := fCriaQuery(Self);
      With qryUpd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLUpdateCfgSis);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODCFG').AsString := 'CFG_CFPACA';
        ParamByName('VALCFG').AsString := fRetornaStringCampos;
        ExecSQL;
      End;
      fMensagem('Informação!','As configurações foram gravadas com sucesso !',['&OK'])
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pAtualizaCfgSisCodigoFabricaProdutoAcabado]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TfrmCadCodFabrProdAcab.pAtualizaGridDireita;
begin
  pInserirNaDireita;
  pExcluirDaEsquerda;
end;

procedure TfrmCadCodFabrProdAcab.pAtualizaGridDireitaTodos;
begin
  pInserirNaDireitaTodos;
end;

procedure TfrmCadCodFabrProdAcab.pAtualizaGridEsquedaTodos;
begin
  pInserirNaEsquerdaTodos;
end;

procedure TfrmCadCodFabrProdAcab.pAtualizaGridEsquerda;
begin
  pInserirNaEsquerda;
  pExcluirDaDireita;
end;

procedure TfrmCadCodFabrProdAcab.pCarregaCdsDireita;
begin
  SetLength(arrDireita,0);
  pLendoCamposDireita(fRetornaCamposDireita);
  if Assigned(arrDireita) then
    pAdicionarCdsDireita;
end;

procedure TfrmCadCodFabrProdAcab.pCarregaCdsEsquerda;
begin
  cdsEsquerda.CreateDataSet;
  cdsEsquerda.IndexFieldNames := 'Sequencia';
  pLendoCamposDireita(fRetornaCamposDireita);
  pLendoCamposEsquerda(fRetornaCamposEsquerda);
  if Assigned(arrEsquerda) then
    pAdicionarCdsEsquerda;
end;

procedure TfrmCadCodFabrProdAcab.pExcluirDaDireita;
begin
  If Not cdsDireita.IsEmpty Then
  cdsDireita.Delete;
end;

procedure TfrmCadCodFabrProdAcab.pExcluirDaEsquerda;
begin
  If Not cdsEsquerda.IsEmpty Then
    cdsEsquerda.Delete;
end;

procedure TfrmCadCodFabrProdAcab.pInserirNaDireitaTodos;
begin
  Try
    cdsEsquerda.DisableControls;
    With cdsDireita Do
    Begin
      cdsEsquerda.First;
      While Not cdsEsquerda.Eof Do
      Begin
        Append;
        FieldByName('DescricaoCampo').AsString := cdsEsquerda.FieldByName('DescricaoCampo').AsString;
        FieldByName('TabelaCampo').AsString    := cdsEsquerda.FieldByName('TabelaCampo').AsString;
        Post;

        cdsEsquerda.Next;
      End;
      cdsEsquerda.EmptyDataSet;
      pSetFocus(dbgDireita);
    End;
  Finally
    cdsEsquerda.EnableControls;
  End;
end;

procedure TfrmCadCodFabrProdAcab.pInserirNaDireita;
begin
  With cdsDireita Do
  Begin
    If Not cdsEsquerda.IsEmpty Then
    Begin
      Append;
      FieldByName('DescricaoCampo').AsString := cdsEsquerda.FieldByName('DescricaoCampo').AsString;
      FieldByName('TabelaCampo').AsString    := cdsEsquerda.FieldByName('TabelaCampo').AsString;
      Post;
      pSetFocus(dbgDireita);
    End;
  End;
end;

procedure TfrmCadCodFabrProdAcab.pInserirNaEsquerda;
var
  intSeq: Integer;
begin
  With cdsEsquerda Do
  Begin
    If Not cdsDireita.IsEmpty Then
    Begin
      intSeq := fRetornaSequenciaGridEsquerda;

      Append;
      FieldByName('DescricaoCampo').AsString := cdsDireita.FieldByName('DescricaoCampo').AsString;
      FieldByName('TabelaCampo').AsString    := cdsDireita.FieldByName('TabelaCampo').AsString;
      FieldByName('Sequencia').AsInteger     := intSeq;
      Post;
      pSetFocus(dbgEsquerda);
    End;  
  End;
end;

procedure TfrmCadCodFabrProdAcab.pInserirNaEsquerdaTodos;
var
  intSeq: Integer;
begin
  Try
    cdsDireita.DisableControls;
    With cdsEsquerda Do
    Begin
      cdsDireita.First;
      While Not cdsDireita.Eof Do
      Begin
        intSeq := fRetornaSequenciaGridEsquerda;

        Append;
        FieldByName('DescricaoCampo').AsString := cdsDireita.FieldByName('DescricaoCampo').AsString;
        FieldByName('TabelaCampo').AsString    := cdsDireita.FieldByName('TabelaCampo').AsString;
        FieldByName('Sequencia').AsInteger     := intSeq;
        Post;
        
        cdsDireita.Next;
      End;
      cdsDireita.EmptyDataSet;
      pSetFocus(dbgEsquerda);
    End;
  Finally
    cdsDireita.EnableControls;
  End;
end;

procedure TfrmCadCodFabrProdAcab.pLendoCamposDireita(strCampos: String);
var
  intCont: Integer;
begin
  SetLength(arrDireita,fCountCamposDireita(strCampos,'",'));
  For intCont := 0 To Length(arrDireita) - 1 Do
  Begin
    If Pos('",',strCampos) > 0 Then
      arrDireita[intCont].strDescricao   := Trim(Copy(strCampos,Pos('"',strCampos) + 1,(Pos('",',strCampos) - 2) - Pos('"',strCampos) + 1))
    Else
      arrDireita[intCont].strDescricao   := Trim(Copy(strCampos,Pos('"',strCampos) + 1,(Length(strCampos) - 2) - Pos('"',strCampos) + 1));

    arrDireita[intCont].strTabelaCampo := Trim(Copy(strCampos,1,Pos('AS ',strCampos) - 1));

    strCampos := Trim(Copy(strCampos,Pos('",',strCampos) + 2,Length(strCampos)));
  End;
end;

procedure TfrmCadCodFabrProdAcab.pLendoCamposEsquerda(strCampos: String);
var
  intCont: Integer;
  intContDir: Integer;
begin
  SetLength(arrEsquerda,fCountCamposEsquerda(strCampos,'+'));
  For intCont := 0 To Length(arrEsquerda) - 1 Do
  Begin
    If (Pos('+', strCampos) > 0) Then
    Begin
      For intContDir := 0 To Length(arrDireita) - 1 Do
        If Pos(arrDireita[intContDir].strTabelaCampo,Trim(Copy(strCampos,1,Pos('+',strCampos) - 1))) > 0 then
          arrEsquerda[intCont].strTabelaCampo := arrDireita[intContDir].strTabelaCampo;

      arrEsquerda[intCont].strExpressao   := Trim(Copy(strCampos,1,Pos('+',strCampos) - 1));
    End
    Else
    Begin
      For intContDir := 0 To Length(arrDireita) - 1 Do
          If Pos(arrDireita[intContDir].strTabelaCampo,strCampos) > 0 then
            arrEsquerda[intCont].strTabelaCampo := arrDireita[intContDir].strTabelaCampo;

      arrEsquerda[intCont].strExpressao   := strCampos;
    End;

    strCampos := Trim(Copy(strCampos,Pos('+',strCampos) + 1,Length(strCampos)));
  End;
end;

procedure TfrmCadCodFabrProdAcab.pMudaOrdemParaBaixo;
  Var
    strSeqAtu: Integer;
    strSeqAnt: Integer;
begin
  With cdsEsquerda Do
  Begin
    strSeqAtu := FieldByName('Sequencia').AsInteger;
    Next;
    strSeqAnt := FieldByName('Sequencia').AsInteger;

    If Locate('Sequencia', strSeqAtu, []) Then
    Begin
      Edit;
      FieldByName('Sequencia').AsInteger := strSeqAnt;
      Post;
    End;

    If Locate('Sequencia', strSeqAnt, []) Then
    Begin
      Edit;
      FieldByName('Sequencia').AsInteger := strSeqAtu;
      Post;
    End;
  End;
end;

procedure TfrmCadCodFabrProdAcab.pMudaOrdemParaCima;
  Var
    strSeqAtu: Integer;
    strSeqAnt: Integer;
begin
  With cdsEsquerda Do
  Begin
    strSeqAtu := FieldByName('Sequencia').AsInteger;
    Prior;
    strSeqAnt := FieldByName('Sequencia').AsInteger;

    If Locate('Sequencia', strSeqAtu, []) Then
    Begin
      Edit;
      FieldByName('Sequencia').AsInteger := strSeqAnt;
      Post;
    End;

    If Locate('Sequencia', strSeqAnt, []) Then
    Begin
      Edit;
      FieldByName('Sequencia').AsInteger := strSeqAtu;
      Post;
    End;
  End;
end;

function TfrmCadCodFabrProdAcab.fRetornaCamposDireita: String;
var
  strSQL: String;
begin
  //Sempre adicionar os campos antes do from, dessa maneira ex: CADMAR.MAR_DESMAR AS "Marca"
  strSQL := '';
  strSQL := strSQL + 'SELECT CADMAR.MAR_CODMAR AS "Código da Marca",          ';
  strSQL := strSQL + '       LEFT(CADGRU.GRU_CODGRU,3) AS "Código da Linha",  ';
  strSQL := strSQL + '       RIGHT(CADGRU.GRU_CODGRU,3) AS "Código do Grupo", ';
  strSQL := strSQL + '       CADCOR.COR_CODCOR AS "Código da Cor",     ';
  strSQL := strSQL + '       CADITE.ITE_CODITE AS "Código do Item",    ';
  strSQL := strSQL + '       CADUNI.UNI_CODUNI AS "Código da Unidade", ';
  strSQL := strSQL + '       CADITE.ITE_REFERE AS "Referencia do Item"     ';
  strSQL := strSQL + '  FROM CADITE                                 ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
  strSQL := strSQL + '  LEFT JOIN CADCOR ON COR_CODCOR = ITE_CODCOR ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + 'WHERE FALSE                                   ';

  Result := Copy(strSQL,Pos('SELECT ',strSQL) + 7,Pos('FROM ',strSQL) - 8);
end;

function TfrmCadCodFabrProdAcab.fRetornaCamposEsquerda: String;
var
  qryCon: TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Self);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLConsultaCfgSis);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODCFG').AsString := 'CFG_CFPACA';
        Open;

        Result := FieldByName('SIS_VALCFG').AsString;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRetornaCamposEsquerda]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TfrmCadCodFabrProdAcab.fRetornaSequenciaGridEsquerda: Integer;
begin
  With cdsEsquerda Do
  Begin
    Last;
    If Not IsEmpty then
      Result := FieldByName('Sequencia').AsInteger + 1
    Else
      Result := 0;
  End;
end;

function TfrmCadCodFabrProdAcab.fRetornaSQLConsultaCfgSis: String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SIS_VALCFG  ';
  strSQL := strSQL + '  FROM CFGSIS      ';
  strSQL := strSQL + ' WHERE SIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND SIS_CODCFG = :CODCFG ';

  Result := strSQL;
end;

function TfrmCadCodFabrProdAcab.fRetornaSQLUpdateCfgSis: String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE CFGSIS ';
  strSQL := strSQL + '   SET SIS_VALCFG = :VALCFG ';
  strSQL := strSQL + ' WHERE SIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND SIS_CODCFG = :CODCFG ';

  Result := strSQL;
end;

function TfrmCadCodFabrProdAcab.fRetornaStringCampos: String;
begin
  Result := '';
  With cdsEsquerda Do
  Begin
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(Result) Then
        Result := IIF(fEmptyStr(FieldByName('Expressao').AsString),FieldByName('TabelaCampo').AsString,FieldByName('Expressao').AsString)
      Else
        Result := Result + '+' + IIF(fEmptyStr(FieldByName('Expressao').AsString),FieldByName('TabelaCampo').AsString,FieldByName('Expressao').AsString);

      Next;
    End;
  End;
end;

end.
