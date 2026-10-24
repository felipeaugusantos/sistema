unit untExportarArquivosTinta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, Uni,System.StrUtils,
  frxExportCSVTestabilidade, Vcl.Menus, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Vcl.Mask, MaskEditFocus, Datasnap.DBClient, UniClientDataSet;

type
  TfrmExportarArquivosTinta = class(TfrmPai)
    btnGerar: TBitBtnLocked;
    pnlTop: TPanel;
    pnlBotton: TPanel;
    Panel3: TPanel;
    dbgRegistros: TDBGridCitel;
    rdgStatus: TRadioGroup;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Label1: TLabel;
    dtsRegistros: TDataSource;
    cdsRegistros: TUniClientDataSet;
    Panel1: TPanel;
    btnRegistros: TBitBtnLocked;
    Panel2: TPanel;
    lblQuantidade: TLabel;
    procedure dbgRegistrosDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dtsRegistrosDataChange(Sender: TObject; Field: TField);
    procedure btnRegistrosClick(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pMarcarTodos;
    procedure pDesmarcarTodos;

    procedure pPreencherDataSetPrincipal;

    function fRetVolume(strMd5Key : String) : String;
    function fRetDirArquivo(strAutoincrem : String) : String;


    function fGetPath : String;

    procedure pGravarLog(strAutoIncrem, strNomeArquivo : String);

  public
    { Public declarations }
    cdsAux    : TUniClientDataSet;
    strCfgExi : String;

  end;

const
  fltFator = 0.308;

var
  frmExportarArquivosTinta: TfrmExportarArquivosTinta;

implementation

{$R *.dfm}

uses untFuncoesSimples ;

{ TfrmExportarArquivosTinta }


procedure TfrmExportarArquivosTinta.btnGerarClick(Sender: TObject);
Var
  QryAux    : TUniQuery;
  intCont   : Integer;
  intAux    : Integer;
  strLinha  : String;
  intForm   : Integer;
  strNomArq : String;
  ArqTxt    : TextFile;
begin
  inherited;


  If (dbgRegistros.SelectedRows.Count = 0) Or (cdsRegistros.RecordCount = 0) Then
  Begin
    fMensagem('','Selecione algum registro para iniciar o processo de exportação!', ['&Ok']);
    Exit;
  End;

  If (rdgStatus.ItemIndex =  1) And (dbgRegistros.SelectedRows.Count > 0 )Then
  Begin
    fMensagem('','Os registros selecionados já foram exportados!', ['&Ok']);
    Exit;
  End;

  If Not DirectoryExists(fGetPath) Then
  Begin
    fMensagem('','O caminho para exportar formulação de tinta de máquina não foi configurado corretamente!', ['&Ok']);
    Exit;
  end;

  strNomArq := FormatDateTime('YYYYDDMM', VS_Date) +'_' +
    FormatDateTime('hhmmss', fTime())  + '_' +  VS_strCodEmp + '_' +
      strLoginUsuarioLogado;

  AssignFile(ArqTxt, fGetPath + '\'+ strNomArq +'.txt');


  Try
    QryAux := fCriaQuery(Nil);


    if dbgRegistros.SelectedRows.Count > 0 then
    Begin
      Rewrite(ArqTxt);

      For intCont := 0 To dbgRegistros.SelectedRows.Count - 1 Do
      Begin
        dtsRegistros.DataSet.GotoBookmark(dbgRegistros.SelectedRows.Items[intCont]);

        QryAux.Close;
        QryAux.SQL.Text := 'SELECT * '+
                           '  FROM CORIMO_CADCOR '+
                           ' WHERE COR_MD5KEY = :MD5KEY';
        QryAux.ParamByName('MD5KEY').AsString :=
          dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or
            (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITETIN').AsString;
        QryAux.Open;

        For intAux := 1 To dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDITE').AsInteger DO
        Begin

          strLinha := '';

          strLinha := strLinha + QryAux.FieldByName('COR_CODIGO').AsString + ';';

          If Not fEmptyStr(QryAux.FieldByName('COR_UNIVER').AsString) Then
            strLinha := strLinha + QryAux.FieldByName('COR_UNIVER').AsString + ';'
          Else
            strLinha := strLinha + ''''''+ ';';

          strLinha := strLinha + QryAux.FieldByName('COR_COLID2').AsString + ';';

          For intForm := 1 To 20 Do
          Begin
            If fEmptyStr(dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or
              (strCfgExi = 'PA'), 'DET', 'FDO') + '_FORM' + fStrZero(intForm, 2)).AsString) Then
            Begin
              strLinha := strLinha + ';';
              Break;
            End;

            If intForm = 1 Then
              strLinha := strLinha + dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or
                (strCfgExi = 'PA'), 'DET', 'FDO') + '_FORM' + fStrZero(intForm, 2)).AsString +','
            Else
              strLinha := strLinha + ',' + dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or
                (strCfgExi = 'PA'), 'DET', 'FDO') + '_FORM' + fStrZero(intForm, 2)).AsString +',';

            strLinha := strLinha +
              AnsiReplaceStr(FloatToStr((dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or
                (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDB' + fStrZero(intForm, 2)).AsFloat / fltFator)), ',','.');

          End;

          strLinha := strLinha + QryAux.FieldByName('COR_EMB_ID').AsString + ';';
          strLinha := strLinha + QryAux.FieldByName('COR_ID_EMB').AsString + ';';
          strLinha := strLinha + dtsRegistros.DataSet.FieldByName('DTAENT').AsString+ ';';
          strLinha := strLinha + dtsRegistros.DataSet.FieldByName('HORENT').AsString+ ';';
          strLinha := strLinha + dtsRegistros.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or
            (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString+ ';';

          Writeln(ArqTxt,strLinha);
        End;

        pGravarLog(dtsRegistros.DataSet.FieldByName('AUTOINCREM').AsString, strNomArq);

      End;

      Closefile(ArqTxt);

      fMensagem('','O arquivo '+ strNomArq +' foi exportado para o diretório : '+
        fGetPath, ['&Ok']);
      Close;


    End;
  Finally
    FreeAndNil(QryAux);
  End;
end;

procedure TfrmExportarArquivosTinta.btnRegistrosClick(Sender: TObject);
begin
  If cdsRegistros.IsEmpty Then
    Exit;

  If btnRegistros.Caption = '&Marcar Todos' Then
    pMarcarTodos
  Else
    pDesmarcarTodos;
end;

procedure TfrmExportarArquivosTinta.dbgRegistrosDrawColumnCell(Sender: TObject; const [Ref]
  Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If fEmptyStr(cdsRegistros.FieldByName('SEQ_EXPARQ').AsString)  then
    dbgRegistros.Canvas.Font.Color:= clBlue
  else
    dbgRegistros.Canvas.Font.Color:= clRed;

  If (State = [gdSelected]) And (dbgRegistros.Focused) Then
   dbgRegistros.Canvas.Font.Color := clWhite;

  dbgRegistros.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmExportarArquivosTinta.dtsRegistrosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  lblQuantidade.Caption := 'Quantidade de Registros: ' + IntToStr(cdsRegistros.RecordCount);
end;

function TfrmExportarArquivosTinta.fGetPath: String;
Var
  QryAux : TUniQuery;
begin

  Try
    QryAux := fCriaQuery(Nil);
    QryAux.Close;
    QryAux.SQL.Text := 'SELECT CFG_VALCFG '+
                       '  FROM CFGTIN '+
                       ' WHERE CFG_CODEMP = :CODEMP  '+
                       '   AND CFG_CODCFG = "EXPARQ" '+
                       '   AND CFG_IDEPRO = "CIM"    ';

    QryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    QryAux.Open;

    Result := QryAux.FieldByName('CFG_VALCFG').AsString;

  Finally
    If Assigned(QryAux) Then FreeAndNil(QryAux);
  End;


end;

procedure TfrmExportarArquivosTinta.FormCreate(Sender: TObject);
begin
  strCfgExi := fCfgSis('EXIDOC');

  inherited;
  dbgRegistros.Columns[0].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC';
  dbgRegistros.Columns[1].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC';
  dbgRegistros.Columns[2].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DTAENT';
  dbgRegistros.Columns[3].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP';
  dbgRegistros.Columns[4].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI';
  dbgRegistros.Columns[5].FieldName  := 'UNI_DESUNI';
  dbgRegistros.Columns[6].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDEMB';
  dbgRegistros.Columns[7].FieldName  := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NOMCLI';
  dbgRegistros.Columns[8].FieldName  := 'ITE_PREVE1';
  dbgRegistros.Columns[9].FieldName  := 'AUTOINCREM';
  dbgRegistros.Columns[10].FieldName := 'DIRARQEXP';
end;

procedure TfrmExportarArquivosTinta.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsAux) Then FreeAndNil(cdsAux);

end;

procedure TfrmExportarArquivosTinta.FormShow(Sender: TObject);
begin
  inherited;
  pPreencherDataSetPrincipal;
end;

function TfrmExportarArquivosTinta.fRetDirArquivo(strAutoincrem: String): String;
Var
  QryAux : TUniQuery;
begin

  Try
    QryAux := fCriaQuery(Nil);
    QryAux.Close;
    QryAux.SQL.Text := 'SELECT ARQ_NOMARQ '+
                       '  FROM EXPARQ '+
                       ' WHERE AUTOINCREM = :AUTOINCREM';
    QryAux.ParamByName('AUTOINCREM').AsString := strAutoincrem;
    QryAux.Open;

    Result := fGetPath + '\'+ QryAux.FieldByName('ARQ_NOMARQ').AsString;

  Finally
    If Assigned(QryAux) Then FreeAndNil(QryAux);
  End;

end;

function TfrmExportarArquivosTinta.fRetVolume(strMd5Key : String): String;
Var
  QryAux : TUniQuery;
begin

  Try
    QryAux := fCriaQuery(Nil);
    QryAux.Close;
    QryAux.SQL.Text := 'SELECT COR_CODEMB '+
                       '  FROM CORIMO_CADCOR '+
                       ' WHERE COR_MD5KEY = :MD5KEY';
    QryAux.ParamByName('MD5KEY').AsString := strMd5Key;
    QryAux.Open;

    Result := QryAux.FieldByName('COR_CODEMB').AsString;

  Finally
    If Assigned(QryAux) Then FreeAndNil(QryAux);
  End;

end;

procedure TfrmExportarArquivosTinta.pDesmarcarTodos;
var
  intCont: Integer;
begin
  Try
    dbgRegistros.DataSource.DataSet.DisableControls;

    With dbgRegistros.DataSource.DataSet do
    begin
      First;

      For intCont := 0 to RecordCount - 1 do
      Begin
        dbgRegistros.SelectedRows.CurrentRowSelected := False;
        Next;
      End;
    End;

    dbgRegistros.DataSource.DataSet.First;

    dbgRegistros.Refresh;

    btnRegistros.Caption := '&Marcar Todos';
  Finally
    dbgRegistros.DataSource.DataSet.EnableControls;
  End;
end;

procedure TfrmExportarArquivosTinta.pGravarLog(strAutoIncrem, strNomeArquivo: String);
Var
  QryAux : TUniQuery;
begin
  Try
    QryAux := fCriaQuery(Nil);
    QryAux.SQL.Text := 'SELECT * FROM EXPARQ WHERE FALSE;';
    QryAux.Open;

    QryAux.Insert;
    QryAux.FieldByName('AUTOINCREM').AsString   := strAutoIncrem;
    QryAux.FieldByName('ARQ_CODEMP').AsString   := VS_strCodEmp;
    QryAux.FieldByName('ARQ_CODOPE').AsString   := strLoginUsuarioLogado;
    QryAux.FieldByName('ARQ_DTAEXP').AsDateTime := Date;
    QryAux.FieldByName('ARQ_HOREXP').AsDateTime := fTime();
    QryAux.FieldByName('ARQ_NOMARQ').AsString   := strNomeArquivo;
    QryAux.Post;


    cdsRegistros.Locate('AUTOINCREM',strAutoIncrem,[]);

    cdsRegistros.Edit;
    cdsRegistros.FieldByName('DIRARQEXP').AsString  := fRetDirArquivo(cdsAux.FieldByName('AUTOINCREM').AsString);
    cdsRegistros.Post;


  Finally
    FreeAndNil(QryAux);
  End;

end;

procedure TfrmExportarArquivosTinta.pMarcarTodos;
Var
  intCont: Integer;
begin
  Try
    dbgRegistros.DataSource.DataSet.DisableControls;

    With dbgRegistros.DataSource.DataSet do
    begin
      First;

      For intCont := 0 to RecordCount - 1 do
      Begin
        dbgRegistros.SelectedRows.CurrentRowSelected := True;
        Next;
      End;
    End;

    dbgRegistros.DataSource.DataSet.First;

    dbgRegistros.SelectedRows.Refresh;

    btnRegistros.Caption := '&Desmarcar Todos'
  Finally
    dbgRegistros.DataSource.DataSet.EnableControls;
  End;
end;

procedure TfrmExportarArquivosTinta.pPreencherDataSetPrincipal;
Begin
  pCloneDataSet(cdsRegistros , cdsAux);

  cdsAux.First;

  While Not cdsAux.Eof Do
  Begin
    cdsRegistros.Locate('AUTOINCREM',cdsAux.FieldByName('AUTOINCREM').AsString, []);

    cdsRegistros.Edit;
    cdsRegistros.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDEMB').AsString := fRetVolume(cdsAux.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITETIN').AsString);
    cdsRegistros.FieldByName('DIRARQEXP').AsString   := fRetDirArquivo(cdsAux.FieldByName('AUTOINCREM').AsString);
    cdsRegistros.post;

    cdsAux.Next;
  End;

  cdsRegistros.Filter   := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO')+'_IDEPRO = ''CIM'' AND SEQ_EXPARQ IS NULL';
  cdsRegistros.Filtered := true;

end;

procedure TfrmExportarArquivosTinta.rdgStatusClick(Sender: TObject);
begin
  inherited;
  If rdgStatus.ItemIndex = 0 Then
  Begin
    cdsRegistros.Filter   := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO = ''CIM'' AND SEQ_EXPARQ IS NULL';
    cdsRegistros.Filtered := true;
    dbgRegistros.Columns[10].Visible := false;
  End
  else
  Begin
    cdsRegistros.Filter   := IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO = ''CIM'' AND SEQ_EXPARQ IS NOT NULL';
    cdsRegistros.Filtered := true;
    dbgRegistros.Columns[10].Visible := true;
  End;

end;

end.
