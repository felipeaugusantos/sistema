unit untSelFatDigTipoEntregaItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, Vcl.Grids, Vcl.DBGrids, untFuncoesSimples,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, UniClientDataSet, untFuncFat, System.UITypes,
  DBGridCitel, untConstantes, StrUtils;

type
  TTipoSelecao = (tsTodos = 1, tsSaldoSuficiente = 2, tsSaldoInsuficiente = 3);

  TTipoSelecaoHelper = Record Helper for TTipoSelecao
    function GetDescricao      : String;
    function GetOpcaoDeSelecao : TTipoSelecao;
  End;

type
  TfrmSelFatDigTipoEntregaItens = class(TfrmPai)
    dtsItens: TDataSource;
    btnOk: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    dbgItens: TDBGridCitel;
    lblEnter: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    FblnSelecao: Boolean;
    FArrSelecao: Array of Integer;
    FArrSelecaoAutoIncrem: TArrayString;
    iIndex: Integer;
    FstrEspDoc: string;
    FstrNumDoc: string;
    FstrCodEmp: string;
    FArrItensEntregaImediata: Array of Integer;
    FArrSemSelecaoAutoIncrem: TArrayString;
    function fEhItemEntregaImediata: Boolean;
    function fCriaTemporaria(Owner: TComponent): TUniClientDataSet;
    procedure pAdicionaItens;
    function getArrSelecao: String;
    procedure pAfterScroll(dataset: tdataset);
    function fPossuiAlgumLote: Boolean;
    function getArrItensEntregaImediata: string;

    procedure pMarcar;
    procedure pDesmarcar;
    procedure pAlternarMarcacao;

    procedure pMarcarTodos;
    procedure pDesmarcarTodos;

  public
    cdsItens: TUniClientDataSet;
    fatVenda: TFatVenda;
    property blnSelecao: Boolean read FblnSelecao;
    property arrSelecao: string read getArrSelecao;
    property arrSelecaoAutoIncrem: TArrayString read FArrSelecaoAutoIncrem;
    property strNumDoc: string read FstrNumDoc write FstrNumDoc;
    property strEspDoc: string read FstrEspDoc write FstrEspDoc;
    property strCodEmp: string read FstrCodEmp write FstrCodEmp;
    property arrItensEntregaImediata: string read getArrItensEntregaImediata;
    property arrSemSelecaoAutoIncrem: TArrayString read FArrSemSelecaoAutoIncrem write FArrSemSelecaoAutoIncrem;
  end;


implementation

{$R *.dfm}

uses
  Uni;

procedure TfrmSelFatDigTipoEntregaItens.pAdicionaItens;
var
  qryItens: TUniQuery;
  strEmpSal, strNumLot: String;
  blnIgnorarLote: Boolean;
begin
  cdsItens.Open;

  if fEmptyStr(strNumDoc) then
  begin
    cdsVenda.First;
    cdsVenda.DisableControls;
    While Not cdsVenda.Eof Do
    Begin
      strNumLot := cdsVenda.FieldByName('ITE_NUMLOT').AsString;

      blnIgnorarLote := False;

      If Assigned(fatVenda) Then
      Begin
        strEmpSal := IIF(fatVenda.blnEmpFat, cdsVenda.FieldByName('ITE_EMPITE').AsString, fatVenda.fEmpresaSaldoMatriz_CD);
        If fatVenda.fIgnorarLote(strEmpSal, cdsVenda.FieldByName('ITE_CODITE').AsString) Then
          strNumLot := '';

        blnIgnorarLote := (fUtilizaDefinicaoLoteSeparacaoSemWMS(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                                cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                                fatVenda.strOpcDoc) And (strNumLot = 'A DEFINIR'));
      End;

      cdsItens.Append;
      cdsItens.FieldByName('AUTOINCREM').AsString  := cdsVenda.FieldByName('AUTOINCREM').AsString;
      cdsItens.FieldByName('ITE_ORDITE').AsInteger := cdsVenda.FieldByName('ITE_ORDITE').AsInteger;
      cdsItens.FieldByName('ITE_CODITE').AsString  := cdsVenda.FieldByName('ITE_CODITE').AsString;
      cdsItens.FieldByName('ITE_DESITE').AsString  := cdsVenda.FieldByName('ITE_DESITE').AsString;
      cdsItens.FieldByName('ITE_EMPITE').AsString  := cdsVenda.FieldByName('ITE_EMPITE').AsString;
      cdsItens.FieldByName('ITE_ENTRET').AsString  := IIF(cdsVenda.FieldByName('ITE_ENTRET').AsString = 'R', 'RETIRA', 'ENTREGA');
      cdsItens.FieldByName('ITE_MOTFUT').AsString  := AnsiUpperCase(fMotivoSiglaToEntFut(cdsVenda.FieldByName('ITE_MOTFUT').AsString));
      cdsItens.FieldByName('ITE_QTDITE').AsFloat   := cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
      cdsItens.FieldByName('ITE_UNIDIG').AsFloat   := cdsVenda.FieldByName('ITE_UNIDIG').AsFloat;
      cdsItens.FieldByName('ITE_TOTITE').AsFloat   := cdsVenda.FieldByName('ITE_TOTITE').AsFloat;
      cdsItens.FieldByName('ITE_DTENTR').AsDateTime:= cdsVenda.FieldByName('ITE_DTENTR').AsDateTime;
      cdsItens.FieldByName('ITE_NUMLOT').AsString  := strNumLot;
      cdsItens.FieldByName('SELECAO').AsString     := 'N';
      cdsItens.FieldByName('ITE_SALDIS').AsFloat   := fRetornaSaldoDisponivel(
        cdsItens.FieldByName('ITE_CODITE').AsString, //strCodIte: String
        False,                                       //blnCnvMl : Boolean = False
        True,                                        //blnFaturamento: Boolean = True
        strNumLot,                                   //strNumLot : String = ''
        True,                                        //blnConsiderarPedidos : Boolean
        cdsItens.FieldByName('ITE_EMPITE').AsString,  //strCodEmp: String = ''
        '',
        False,
        True,
        True,
        blnIgnorarLote
      );
      cdsItens.FieldByName('ITE_SALFIS').AsFloat   := fRetornaSaldoFisico(
        cdsItens.FieldByName('ITE_CODITE').AsString, //strCodIte: String
        True,                                        //blnFaturamento: Boolean = True
        strNumLot,                                   //strNumLot : String = ''
        cdsItens.FieldByName('ITE_EMPITE').AsString,  //strCodEmp: String = ''
        blnIgnorarLote
      );

      If (cdsVenda.FieldByName('ITE_DTENTR').AsString = '31/12/9999') Or (cdsVenda.FieldByName('ITE_DTENTR').AsString = '') Then
        cdsItens.FieldByName('ITE_QDENTR').AsInteger := 0
      Else
        cdsItens.FieldByName('ITE_QDENTR').AsString := FloatToStr(StrToDateDef(cdsVenda.FieldByName('ITE_DTENTR').AsString, 0) - VS_Date);

      If (cdsItens.FieldByName('ITE_ENTRET').AsString = 'RETIRA') Then
        cdsItens.FieldByName('ITE_TIPENT').AsString := ''
      Else
        cdsItens.FieldByName('ITE_TIPENT').AsString := IIF(cdsVenda.FieldByName('ITE_ENTFUT').AsString = 'S', 'FUTURA', 'IMEDIATA');

      cdsItens.FieldByName('ITE_CLIBUS').AsString  := IIF(cdsVenda.FieldByName('ITE_CLIBUS').AsString = 'S', 'SIM', 'NÃO');
      cdsItens.FieldByName('ITE_TURENT').AsString  := AnsiUpperCase(cdsVenda.FieldByName('ITE_TURENT').AsString);

      cdsItens.Post;
      cdsVenda.Next;
    End;
    cdsVenda.First;
    cdsVenda.EnableControls;
  end
  else
  begin
    qryItens := fCriaQuery;
    try
      qryItens.SQL.Add('SELECT');
      qryItens.SQL.Add('  FATDOR.AUTOINCREM,');
      qryItens.SQL.Add('  FDO_CODITE,');
      qryItens.SQL.Add('  FDO_NUMLOT,');
      qryItens.SQL.Add('  ITE_DESITE,');
      qryItens.SQL.Add('  FDO_EMPITE,');
      qryItens.SQL.Add('  FDO_ENTRET,');
      qryItens.SQL.Add('  FDO_MOTFUT,');
      qryItens.SQL.Add('  FDO_QTDITE,');
      qryItens.SQL.Add('  FDO_UNIDIG,');
      qryItens.SQL.Add('  FDO_TOTITE,');
      qryItens.SQL.Add('  FDO_DTENTR,');
      qryItens.SQL.Add('  FDO_QDENTR,');
      qryItens.SQL.Add('  FDO_ENTFUT,');
      qryItens.SQL.Add('  FDO_TURENT ');
      qryItens.SQL.Add('FROM');
      qryItens.SQL.Add('  FATGOR');
      qryItens.SQL.Add('  INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER');
      qryItens.SQL.Add('  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO');
      qryItens.SQL.Add('  INNER JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE');
      qryItens.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
      qryItens.SQL.Add('  AND FGO_ESPDOC = :ESPDOC');
      qryItens.SQL.Add('  AND FGO_CODEMP = :CODEMP');
      qryItens.ParamByName('NUMDOC').AsString := FstrNumDoc;
      qryItens.ParamByName('ESPDOC').AsString := FstrEspDoc;
      qryItens.ParamByName('CODEMP').AsString := FstrCodEmp;
      qryItens.Open;

      qryItens.First;
      While Not qryItens.Eof Do
      Begin
        blnIgnorarLote := False;

        If Assigned(fatVenda) Then
          blnIgnorarLote := (fUtilizaDefinicaoLoteSeparacaoSemWMS(qryItens.FieldByName('FDO_CODITE').AsString,
                                                                  qryItens.FieldByName('FDO_EMPITE').AsString,
                                                                  fatVenda.strOpcDoc) And
                            (qryItens.FieldByName('FDO_NUMLOT').AsString = 'A DEFINIR'));



        cdsItens.Append;
        cdsItens.FieldByName('ITE_ORDITE').AsInteger := cdsItens.RecordCount + 1;
        cdsItens.FieldByName('AUTOINCREM').AsString  := qryItens.FieldByName('AUTOINCREM').AsString;
        cdsItens.FieldByName('ITE_CODITE').AsString  := qryItens.FieldByName('FDO_CODITE').AsString;
        cdsItens.FieldByName('ITE_DESITE').AsString  := qryItens.FieldByName('ITE_DESITE').AsString;
        cdsItens.FieldByName('ITE_EMPITE').AsString  := qryItens.FieldByName('FDO_EMPITE').AsString;
        cdsItens.FieldByName('ITE_ENTRET').AsString  := IIF(qryItens.FieldByName('FDO_ENTRET').AsString = 'R', 'RETIRA', 'ENTREGA');
        cdsItens.FieldByName('ITE_MOTFUT').AsString  := AnsiUpperCase(fMotivoSiglaToEntFut(qryItens.FieldByName('FDO_MOTFUT').AsString));
        cdsItens.FieldByName('ITE_QTDITE').AsFloat   := qryItens.FieldByName('FDO_QTDITE').AsFloat;
        cdsItens.FieldByName('ITE_UNIDIG').AsFloat   := qryItens.FieldByName('FDO_UNIDIG').AsFloat;
        cdsItens.FieldByName('ITE_TOTITE').AsFloat   := qryItens.FieldByName('FDO_TOTITE').AsFloat;
        cdsItens.FieldByName('ITE_DTENTR').AsDateTime:= qryItens.FieldByName('FDO_DTENTR').AsDateTime;
        cdsItens.FieldByName('ITE_NUMLOT').AsString  := qryItens.FieldByName('FDO_NUMLOT').AsString;
        cdsItens.FieldByName('SELECAO').AsString     := 'N';
        cdsItens.FieldByName('ITE_SALDIS').AsFloat   := fRetornaSaldoDisponivel(
          qryItens.FieldByName('FDO_CODITE').AsString, //strCodIte: String
          False,                                       //blnCnvMl : Boolean = False
          True,                                        //blnFaturamento: Boolean = True
          qryItens.FieldByName('FDO_NUMLOT').AsString, //strNumLot : String = ''
          True,                                        //blnConsiderarPedidos : Boolean
          qryItens.FieldByName('FDO_EMPITE').AsString,  //strCodEmp: String = ''
          '',
          False,
          True,
          True,
          blnIgnorarLote
        );
        cdsItens.FieldByName('ITE_SALFIS').AsFloat   := fRetornaSaldoFisico(
          qryItens.FieldByName('FDO_CODITE').AsString, //strCodIte: String
          True,                                        //blnFaturamento: Boolean = True
          qryItens.FieldByName('FDO_NUMLOT').AsString, //strNumLot : String = ''
          qryItens.FieldByName('FDO_EMPITE').AsString,  //strCodEmp: String = ''
          blnIgnorarLote
        );

        If (cdsItens.FieldByName('ITE_DTENTR').AsString = '31/12/9999') Then
          cdsItens.FieldByName('ITE_QDENTR').AsInteger := 0
        Else
          cdsItens.FieldByName('ITE_QDENTR').AsString := FloatToStr(StrToDateDef(cdsItens.FieldByName('ITE_DTENTR').AsString, 0) - VS_Date);

        If (cdsItens.FieldByName('ITE_ENTRET').AsString = 'RETIRA') Then
          cdsItens.FieldByName('ITE_TIPENT').AsString := ''
        Else
          cdsItens.FieldByName('ITE_TIPENT').AsString := IIF(qryItens.FieldByName('FDO_ENTFUT').AsString = 'S', 'FUTURA', 'IMEDIATA');

        cdsItens.FieldByName('ITE_CLIBUS').AsString  :=IIF((qryItens.FieldByName('FDO_ENTFUT').AsString = 'N') And (qryItens.FieldByName('FDO_ENTRET').AsString = 'R'), 'SIM', 'NÃO');
        cdsItens.FieldByName('ITE_TURENT').AsString  := AnsiUpperCase(qryItens.FieldByName('FDO_TURENT').AsString);

        cdsItens.Post;
        qryItens.Next;
      End;
    finally
      FreeAndNil(qryItens);
    end;
  end;
end;

procedure TfrmSelFatDigTipoEntregaItens.pAfterScroll(dataset: tdataset);
begin
  iIndex := cdsItens.recNo;
end;

procedure TfrmSelFatDigTipoEntregaItens.pAlternarMarcacao;
begin

  If Not Assigned(cdsItens) Then
    Exit;

  If cdsItens.IsEmpty Then
    Exit;

  If (cdsItens.FieldByName('SELECAO').AsString.Equals('N')) Then
    pMarcar
  Else
    pDesmarcar;

end;

procedure TfrmSelFatDigTipoEntregaItens.pDesmarcar;
begin

  If Not Assigned(cdsItens) Then
    Exit;

  If cdsItens.IsEmpty Then
    Exit;

  cdsItens.Edit;
  cdsItens.FieldByName('SELECAO').AsString := 'N';
  cdsItens.Post;

end;

procedure TfrmSelFatDigTipoEntregaItens.pDesmarcarTodos;
var
  LPosicao : TBookmark;
begin

  If cdsitens.isEmpty Then
    Exit;

  cdsItens.DisableControls;
  LPosicao := cdsItens.GetBookmark;

  Try

    cdsItens.First;
    While Not cdsItens.eof Do
    Begin
      pDesmarcar;
      cdsItens.Next;
    End;

  Finally

    If cdsItens.BookmarkValid(LPosicao) Then
      cdsItens.GotoBookmark(LPosicao);

    cdsItens.EnableControls;

  End;

end;

procedure TfrmSelFatDigTipoEntregaItens.pMarcar;
begin

  If Not Assigned(cdsItens) Then
    Exit;

  If cdsItens.IsEmpty Then
    Exit;

  cdsItens.Edit;
  cdsItens.FieldByName('SELECAO').AsString := 'S';
  cdsItens.Post;

end;

procedure TfrmSelFatDigTipoEntregaItens.pMarcarTodos;
var
  LPosicao         : TBookmark;
  LTipoSelecao     : TTipoSelecao;
  LSaldoSuficiente : Boolean;
begin

  If cdsitens.IsEmpty Then
    Exit;

  cdsItens.DisableControls;
  LPosicao := cdsItens.GetBookmark;

  Try

    LTipoSelecao := LTipoSelecao.GetOpcaoDeSelecao;
    pDesmarcarTodos;

    cdsItens.First;
    While Not cdsItens.eof Do
    Begin

      LSaldoSuficiente := (cdsItens.FieldByName('ITE_SALDIS').AsFloat >= cdsItens.FieldByName('ITE_QTDITE').AsFloat);

      Case LTipoSelecao Of
        tsTodos             : pMarcar;
        tsSaldoSuficiente   : If (LSaldoSuficiente) Then
                                pMarcar;
        tsSaldoInsuficiente : If Not (LSaldoSuficiente) Then
                                pMarcar;
      End;

      cdsItens.Next;

    End;

  Finally

    If cdsItens.BookmarkValid(LPosicao) Then
      cdsItens.GotoBookmark(LPosicao);

    cdsItens.EnableControls;

  End;

end;

procedure TfrmSelFatDigTipoEntregaItens.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  pDesmarcarTodos;
end;

procedure TfrmSelFatDigTipoEntregaItens.btnMarcarClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmSelFatDigTipoEntregaItens.btnOkClick(Sender: TObject);
var strFilter: String;
    blnFilter: Boolean;
    blnEmpty: Boolean;
begin
  strFilter := cdsItens.Filter;
  blnFilter := cdsItens.Filtered;
  blnEmpty  := False;
  cdsItens.DisableControls;
  Try
    cdsItens.Filter := 'SELECAO = '+QuotedStr('S');
    cdsItens.Filtered := True;
    Self.modalResult := mrNone;

    blnEmpty := cdsItens.isEmpty;

    If Not blnEmpty Then
      Self.modalResult := mrOk;

  Finally
    cdsItens.Filter   := strFilter;
    cdsItens.Filtered := blnFilter;

    cdsItens.EnableControls;
    If blnEmpty Then
      pMensagemOk('Selecione um produto para alteração.');
  End;
end;

procedure TfrmSelFatDigTipoEntregaItens.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  iIndex := cdsItens.recNo;
end;

procedure TfrmSelFatDigTipoEntregaItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Assigned(cdsItens) And Not cdsItens.IsEmpty Then
  Begin

    If cdsItens.recNo = iIndex Then
    Begin
      dbgItens.Canvas.Brush.Color := clAqua;
    End
    Else
    If (cdsItens.RecNo mod 2 = 0) And (dbgItens.Canvas.Brush.Color <> clHighlight) Then
    Begin
      dbgItens.Canvas.Brush.Color := $00EEEEEE;
    End
    Else
      dbgItens.Canvas.Brush.Color := clWindow;

    If cdsItens.FieldByName('SELECAO').AsString = 'S' Then
      dbgItens.Canvas.Font.Color := clBlue
    Else
      dbgItens.Canvas.Font.Color := clBlack;

    dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;
end;

procedure TfrmSelFatDigTipoEntregaItens.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) Or (Key = VK_RETURN) Then
    pAlternarMarcacao;
end;

function TfrmSelFatDigTipoEntregaItens.fEhItemEntregaImediata: Boolean;
begin
  Result := (LeftStr(cdsItens.FieldByName('ITE_ENTRET').AsString, 1) = 'E') And fEmptyStr(cdsItens.FieldByName('ITE_MOTFUT').AsString);
end;

function TfrmSelFatDigTipoEntregaItens.fCriaTemporaria(
  Owner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Owner);

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM'; DataType := ftString; Size := 20;  Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_ORDITE'; DataType := ftInteger;             Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_DESITE'; DataType := ftString; Size := 101; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_EMPITE'; DataType := ftString; Size := 003; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_ENTRET'; DataType := ftString; Size := 007; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_MOTFUT'; DataType := ftString; Size := 020; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_QTDITE'; DataType := ftFloat;               Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_UNIDIG'; DataType := ftFloat;               Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_TOTITE'; DataType := ftFloat;               Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SELECAO'   ; DataType := ftString; Size := 001; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_SALDIS'; DataType := ftFloat;               Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_SALFIS'; DataType := ftFloat;               Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_DTENTR'; DataType := ftDate;                Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_NUMLOT'; DataType := ftString; Size := 030; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_TIPENT'; DataType := ftString; Size := 008; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_QDENTR'; DataType := ftInteger;             Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_CLIBUS'; DataType := ftString; Size := 003; Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITE_TURENT'; DataType := ftString; Size := 005; Required := False; End;

  Result.CreateDataSet;
  Result.LogChanges := False;
end;

procedure TfrmSelFatDigTipoEntregaItens.FormClose(Sender: TObject; var Action: TCloseAction);
var
  iIndiceEnt,
  iIndiceSel,
  iIndiceSelN : Integer;
begin
  inherited;
  cdsItens.DisableControls;
  cdsItens.First;
  iIndiceEnt  := 0;
  iIndiceSel  := 0;
  iIndiceSelN := 0;
  While Not cdsItens.Eof Do
  Begin
    If fEhItemEntregaImediata Then
    Begin
      setLength(FArrItensEntregaImediata, iIndiceEnt + 1);

      FArrItensEntregaImediata[iIndiceEnt] := cdsItens.FieldByName('ITE_ORDITE').AsInteger;

      Inc(iIndiceEnt);
    End;

    If cdsItens.FieldByName('SELECAO').AsString = 'S' Then
    Begin
      setLength(FArrSelecao, iIndiceSel + 1);
      setLength(FArrSelecaoAutoIncrem, iIndiceSel + 1);

      FArrSelecao[iIndiceSel] := cdsItens.FieldByName('ITE_ORDITE').AsInteger;
      FArrSelecaoAutoIncrem[iIndiceSel] := cdsItens.FieldByName('AUTOINCREM').AsString;

      Inc(iIndiceSel);
    End;

    If cdsItens.FieldByName('SELECAO').AsString = 'N' Then
    Begin
      setLength(FArrSemSelecaoAutoIncrem, iIndiceSelN + 1);

      FArrSemSelecaoAutoIncrem[iIndiceSelN] := cdsItens.FieldByName('AUTOINCREM').AsString;

      Inc(iIndiceSelN);
    End;

    cdsItens.Next;
  End;
  cdsItens.EnableControls;
  FblnSelecao := iIndiceSel > 0;
end;

procedure TfrmSelFatDigTipoEntregaItens.FormCreate(Sender: TObject);
begin
  inherited;
  FstrNumDoc := '';
  FstrEspDoc := '';
  FstrCodEmp := '';
  fatVenda   := Nil;
  iIndex := 1;
end;

procedure TfrmSelFatDigTipoEntregaItens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5:
      btnMarcar.Click;
    VK_F6:
      btnDesmarcar.CLick;
    VK_F10:
      btnOK.Click;
    VK_ESCAPE:
      btnSair.Click;
  End;
end;

procedure TfrmSelFatDigTipoEntregaItens.FormShow(Sender: TObject);
begin
  inherited;
  iIndex := 1;
  cdsItens := fCriaTemporaria(Self);
  pAdicionaItens;
  FblnSelecao := False;
  dtsItens.DataSet := cdsItens;
  dtsItens.DataSet.AfterScroll := pAfterScroll;
  With cdsItens Do
  Begin
    If Not isEmpty Then
    Begin
      (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fDisplayFormat(fCfgSis('DECQTD', varInteger));
      (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := fDisplayFormat(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_UNIDIG') As TFloatField).DisplayFormat := fDisplayFormat(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := fDisplayFormat(fCfgSis('DECQTD', varInteger));
      (FieldByName('ITE_SALFIS') As TFloatField).DisplayFormat := fDisplayFormat(fCfgSis('DECQTD', varInteger));
    End;
  End;

  fFindColumnByName(dbgItens, 'ITE_NUMLOT').Visible := fPossuiAlgumLote;
  fFindColumnByName(dbgItens, 'ITE_TIPENT').Visible := fCfgSis('ENTFUT', varBoolean);
  fFindColumnByName(dbgItens, 'ITE_MOTFUT').Visible := fCfgSis('ENTFUT', varBoolean);
  fFindColumnByName(dbgItens, 'ITE_TURENT').Visible := fCfgSis('EXITUR', varBoolean);
  fFindColumnByName(dbgItens, 'ITE_CLIBUS').Visible := fCfgSis('ENTFUT', varBoolean) And fCfgSis('CLBUEF', varBoolean);

  cdsItens.First;
  pSetFocus(dbgItens);
end;

function TfrmSelFatDigTipoEntregaItens.fPossuiAlgumLote: Boolean;
begin
  Result := False;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If Not fEmptyStr(cdsItens.FieldByName('ITE_NUMLOT').AsString) Then
      Begin
        Result := True;
        Break;
      End;
      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

function TfrmSelFatDigTipoEntregaItens.getArrSelecao: String;
var
  iIndice: Integer;
begin
  For iIndice := Low(FArrSelecao) To High(FArrSelecao) Do
  Begin
    result := result + iif(iIndice = Low(FArrSelecao), ' ', ', ') + (intToStr(FArrSelecao[iIndice]));
  End;
end;

function TfrmSelFatDigTipoEntregaItens.getArrItensEntregaImediata: string;
var
  iIndice: Integer;
begin
  For iIndice := Low(FArrItensEntregaImediata) To High(FArrItensEntregaImediata) Do
  Begin
    result := result + iif(iIndice = Low(FArrItensEntregaImediata), ' ', ', ') + (intToStr(FArrItensEntregaImediata[iIndice]));
  End;
end;

{ TTipoSelecaoHelper }

function TTipoSelecaoHelper.GetDescricao: String;
begin
  Case Self Of
    tsTodos             : Result := 'Todos';
    tsSaldoSuficiente   : Result := 'Saldo Suficiente';
    tsSaldoInsuficiente : Result := 'Saldo Insuficiente';
  End;
end;

function TTipoSelecaoHelper.GetOpcaoDeSelecao: TTipoSelecao;
var
  LOpcoes      : Array Of String;
  LOpcao       : TTipoSelecao;
  LNovaPosicao : Integer;
begin

  SetLength(LOpcoes, 0);

  For LOpcao := Low(Self) To High(Self) Do
  Begin

    LNovaPosicao := Succ(Length(LOpcoes));

    SetLength(LOpcoes, LNovaPosicao);
    LOpcoes[Pred(LNovaPosicao)] := LOpcao.GetDescricao;

  End;

  Result := TTipoSelecao(fMensagem('',
                                   'Selecionar: ',
                                   LOpcoes,
                                   1,
                                   False,
                                   1,
                                   150,
                                   False,
                                   0,
                                   False,
                                   False,
                                   True));

end;

end.
