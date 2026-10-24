unit untImportacaoMetasLinhaGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untImportacaoMetas, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, Data.DB, DBAccess, Uni, frxClass, Datasnap.DBClient, UniClientDataSet,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ComCtrls,
  cxProgressBar, cxButtons, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  untDetMetController, untDetMet;

type
  TfrmImportacaoMetasLinhaGrupo = class(TfrmImportacaoMetas)
    cdsDadosMET_CODGRU: TStringField;
    cdsDadosMET_DEFTIP: TStringField;
    cdsDadosMET_PERGRU: TFloatField;
    cdsDadosAUTOINCREM: TStringField;
    cdsDadosMET_MARGRU: TFloatField;
    procedure cdsDadosAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    objController: TDetMetController;

    Const
      QTDCOLUM = 7;

      COL_CODGRU = 'D';
      COL_DEFTIP = 'E';
      COL_PERGRU = 'F';
      COL_MARGRU = 'G';

      DES_CODGRU = 'Código Linha/Grupo';
      DES_DEFTIP = 'Definição Linha/Grupo';
      DES_PERGRU = 'Percentual';
      DES_MARGRU = 'Margem';

    function fValidaCodGru(strCodigo, strCodVen, strMesAno: String; var strMensagem: String): Boolean;
    function fValidaTipo(strTipDef: String; var strMensagem: string): Boolean;
    function fValidaDadosLinha(Const objDetMet: TDetMet; intLinha: Integer): Boolean;
  public
    { Public declarations }
  protected
    procedure pMontaObjValidadorComplementar; override;
    procedure pPreencheCdsDados(intLinha: Integer); override;
    function fGravar: Boolean; override;
    function fValidaPercentuais(cdsClone: TUniClientDataSet; strMesAno, strCodVen, strFiltro: String): Boolean; override;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmImportacaoMetasLinhaGrupo }

procedure TfrmImportacaoMetasLinhaGrupo.cdsDadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pFormataCampoFloat('MET_PERGRU');
  pFormataCampoFloat('MET_MARGRU');
end;

function TfrmImportacaoMetasLinhaGrupo.fValidaCodGru(strCodigo, strCodVen, strMesAno: String; Var strMensagem: String): Boolean;
  Const
    CODGRU = 'GRU_CODGRU';
    TABELA = 'CADGRU';

  Var
    intRecNo: Integer;
begin
  Result := False;
  intRecNo := cdsDados.RecNo;

  If (Not fValidaCodigo(TABELA, [CODGRU], [strCodigo], strMensagem)) Then
    Exit;

  If (cdsDados.FindKey([strMesAno, strCodVen, strCodigo])) Then
  Begin
    cdsDados.RecNo := intRecNo;
    strMensagem := 'Linha/Grupo '+ strCodigo + ' já inserida(o)';
    Exit;
  End;

  cdsDados.RecNo := intRecNo;
  Result := True;
end;

procedure TfrmImportacaoMetasLinhaGrupo.pMontaObjValidadorComplementar;
begin
  inherited;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODGRU, COL_CODGRU, 0, False, False, '', '', False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_DEFTIP, COL_DEFTIP, 0, False, False, '', '', False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_PERGRU, COL_PERGRU, 0, False, False, '', '', False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_MARGRU, COL_MARGRU, 0, False, False, '', '', False));
end;

procedure TfrmImportacaoMetasLinhaGrupo.pPreencheCdsDados(intLinha: Integer);
  Var
    objDetMet: TDetMet;
    fltMarGru: Double;
begin
  inherited;
  fltMarGru := fConverteStringPercentual(objValidaExcel.fGetValueCSV(intLinha, COL_MARGRU));

  objDetMet := TDetMet.Create('',
                              cdsDados.FieldByName('MET_CODEMP').AsString,
                              cdsDados.FieldByName('MET_MESANO').AsString,
                              cdsDados.FieldByName('MET_CODVEN').AsString,
                              objValidaExcel.fGetValueCSV(intLinha, COL_CODGRU),
                              objValidaExcel.fGetValueCSV(intLinha, COL_DEFTIP),
                              fConverteStringPercentual(objValidaExcel.fGetValueCSV(intLinha, COL_PERGRU)),
                              IIF(Not blnExibeMargem, 0, fltMarGru));
  Try
    If (Not fValidaDadosLinha(objDetMet, intLinha)) Then
    Begin
      cdsDados.Delete;
      Exit;
    End;

    cdsDados.Edit;
    cdsDados.FieldByName('MET_CODGRU').AsString := objDetMet.getCodGru;
    cdsDados.FieldByName('MET_DEFTIP').AsString := objDetMet.getDefTip;
    cdsDados.FieldByName('MET_PERGRU').AsFloat  := objDetMet.getPerGru;
    cdsDados.FieldByName('MET_MARGRU').AsFloat  := objDetMet.getMarGru;
    cdsDados.Post;
  Finally
    FreeAndNil(objDetMet);
  End;
end;

function TfrmImportacaoMetasLinhaGrupo.fValidaTipo(strTipDef: String; Var strMensagem: string): Boolean;
begin
  Result := False;

  If (Pos(strTipDef, 'F_M_') <= 0) Then
  Begin
    strMensagem := 'Tipo de definição de Linha/Grupo deve ser igual a "F" ou "M"';
    Exit;
  End;

  Result := True;
end;

function TfrmImportacaoMetasLinhaGrupo.fValidaPercentuais(cdsClone: TUniClientDataSet;
  strMesAno, strCodVen, strFiltro: String): Boolean;
begin
  Result := fValidaSomaPercentuais(cdsClone, strMesAno, strCodVen, strFiltro, 'MET_PERGRU', COL_PERGRU);
end;

function TfrmImportacaoMetasLinhaGrupo.fGravar: Boolean;
begin
  Result := objController.fGravarColecao(cdsDados);
end;

procedure TfrmImportacaoMetasLinhaGrupo.FormCreate(Sender: TObject);
begin
  inherited;

  cdsDados.CreateDataSet;

  intQtdColunas := QTDCOLUM;
  objController := TDetMetController.Create;

end;

procedure TfrmImportacaoMetasLinhaGrupo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objController);
end;

procedure TfrmImportacaoMetasLinhaGrupo.FormShow(Sender: TObject);
begin
  inherited;

  If Not blnExibeMargem Then
  Begin
    dbgDados.Columns[6].Visible := False;
  End;
end;

function TfrmImportacaoMetasLinhaGrupo.fValidaDadosLinha(Const objDetMet: TDetMet; intLinha: Integer): Boolean;
  Var
    strMensagem: String;
    strLinha: String;
begin
  Result := False;
  strlinha := IntToStr(intLinha + 1);

  If (Not fValidaCodGru(objDetMet.getCodGru, objDetMet.getCodVen, objDetMet.getMesAno, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Código Linha/Grupo', COL_CODGRU, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaTipo(objDetMet.getDefTip, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Tipo', COL_DEFTIP, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaPercentual(objDetMet.getPerGru, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Percentual', COL_PERGRU, strlinha, strMensagem);
    Exit;
  End;

  Result := True;
end;

end.
