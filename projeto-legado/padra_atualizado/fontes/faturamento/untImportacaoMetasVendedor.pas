unit untImportacaoMetasVendedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untImportacaoMetas, cxGraphics, Types,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, Data.DB, DBAccess, Uni, frxClass, Datasnap.DBClient, UniClientDataSet,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ComCtrls, Math,
  cxProgressBar, cxButtons, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  untCadMetController, untCadMet;

type
  TfrmImportacaoMetasVendedor = class(TfrmImportacaoMetas)
    cdsDadosMET_TOTMET: TFloatField;
    cdsDadosMET_TOTFRE: TFloatField;
    cdsDadosMET_MARGEM: TFloatField;
    cdsDadosMET_ATEDIA: TFloatField;
    cdsDadosMET_TICMED: TFloatField;
    cdsDadosMET_ITEDOC: TFloatField;
    cdsDadosAUTOINCREM: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cdsDadosAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    blnExibeCamposECMVBI: Boolean;
    objController: TCadMetController;

    Const
      QTDCOLUMORIG = 6;
      QTDCOLUMECMVBI = 9;

      COL_VALFAT = 'D';
      COL_VALFRE = 'E';
      COL_MARGEM = 'F';
      COL_MTATDI = 'G';
      COL_MTTKMD = 'H';
      COL_MTITDC = 'I';

      DES_VALFAT = 'Valor Faturamento';
      DES_VALFRE = 'Valor Frete';
      DES_MARGEM = 'Margem';
      DES_MTATDI = 'Meta Atend. Diário';
      DES_MTTKMD = 'Meta Ticket Médio';
      DES_MTITDC = 'Meta Itens por Doc.';

    procedure pTrataCamposECMVBI;
    function fValidaDadosLinha(const objCadMet: TCadMet; intLinha: Integer): Boolean;
    function fValidaValores(fltValor: Double; var strMensagem: String): Boolean;
  public
    { Public declarations }
  protected
    procedure pMontaObjValidadorComplementar; override;
    procedure pPreencheCdsDados(intLinha: Integer); override;
    function fValidaPercentuais(cdsClone: TUniClientDataSet; strMesAno, strCodVen, strFiltro: String): Boolean; override;
    function fGravar: Boolean; override;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmImportacaoMetasVendedor }

procedure TfrmImportacaoMetasVendedor.cdsDadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pFormataCampoFloat('MET_TOTMET');
  pFormataCampoFloat('MET_TOTFRE');
  pFormataCampoFloat('MET_MARGEM');
  pFormataCampoFloat('MET_ATEDIA');
  pFormataCampoFloat('MET_TICMED');
  pFormataCampoFloat('MET_ITEDOC');
end;

procedure TfrmImportacaoMetasVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  intQtdColunas := QTDCOLUMORIG;
  objController := TCadMetController.Create;
  blnExibeCamposECMVBI := fCfgSis('ECMVBI', varBoolean);
  pTrataCamposECMVBI;
end;

procedure TfrmImportacaoMetasVendedor.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objController);
end;

procedure TfrmImportacaoMetasVendedor.pPreencheCdsDados(intLinha: Integer);
  Var
    objCadMet: TCadMet;
begin
  inherited;
  objCadMet := TCadMet.Create('',
                              cdsDados.FieldByName('MET_CODEMP').AsString,
                              cdsDados.FieldByName('MET_MESANO').AsString,
                              cdsDados.FieldByName('MET_CODVEN').AsString,
                              StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_VALFAT), 0),
                              StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MARGEM), 0),
                              StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_VALFRE), 0),
                              IIF(blnExibeCamposECMVBI, StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MTATDI), 0), 0),
                              IIF(blnExibeCamposECMVBI, StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MTTKMD), 0), 0),
                              IIF(blnExibeCamposECMVBI, StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MTITDC), 0), 0));
  Try
    If (Not fValidaDadosLinha(objCadMet, intLinha)) Then
    Begin
      cdsDados.Delete;
      Exit;
    End;

    cdsDados.Edit;
    cdsDados.FieldByName('MET_TOTMET').AsFloat := objCadMet.getTotMet;
    cdsDados.FieldByName('MET_TOTFRE').AsFloat := objCadMet.getTotFre;;
    cdsDados.FieldByName('MET_MARGEM').AsFloat := objCadMet.getMargem;

    If (blnExibeCamposECMVBI) Then
    Begin
      cdsDados.FieldByName('MET_ATEDIA').AsFloat := objCadMet.getAteDia;
      cdsDados.FieldByName('MET_TICMED').AsFloat := objCadMet.getTicMed;
      cdsDados.FieldByName('MET_ITEDOC').AsFloat := objCadMet.getIteDoc;
    End;

    cdsDados.Post;
  Finally
    FreeAndNil(objCadMet);
  End;
end;

procedure TfrmImportacaoMetasVendedor.pMontaObjValidadorComplementar;
begin
  inherited;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_VALFAT, COL_VALFAT, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_VALFRE, COL_VALFRE, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MARGEM, COL_MARGEM, False));

  If (blnExibeCamposECMVBI) Then
  Begin
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MTATDI, COL_MTATDI, False));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MTTKMD, COL_MTTKMD, False));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MTITDC, COL_MTITDC, False));
  End;
end;

procedure TfrmImportacaoMetasVendedor.pTrataCamposECMVBI;
  Var
    intCont: Integer;
begin
  If (blnExibeCamposECMVBI) Then
    Exit;

  intQtdColunas := QTDCOLUMORIG;

  For intCont := 0 To Pred(dbgDados.Columns.Count) Do
  Begin
    If (Pos(dbgDados.Columns[intCont].FieldName, 'MET_ATEDIA_MET_TICMED_MET_ITEDOC_') > 0) Then
      dbgDados.Columns[intCont].Visible := False;
  End;
end;

function TfrmImportacaoMetasVendedor.fValidaPercentuais(cdsClone: TUniClientDataSet;
  strMesAno, strCodVen, strFiltro: String): Boolean;
begin
  Result := True;
end;

function TfrmImportacaoMetasVendedor.fGravar: Boolean;
begin
  Result := objController.fGravarColecao(cdsDados);
end;

function TfrmImportacaoMetasVendedor.fValidaValores(fltValor: Double; Var strMensagem: String): Boolean;
begin
  Result := False;

  If (CompareValue(fltValor, 0) = LessThanValue) Then
  Begin
    strMensagem := 'Valor não pode ser negativo';
    Exit;
  End;

  Result := True;
end;

function TfrmImportacaoMetasVendedor.fValidaDadosLinha(Const objCadMet: TCadMet; intLinha: Integer): Boolean;
  Var
    strMensagem: String;
    strLinha: String;
begin
  Result := False;
  strlinha := IntToStr(intLinha + 1);

  If (Not fValidaValores(objCadMet.getTotMet, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Vlr. Faturamento', COL_VALFAT, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaValores(objCadMet.getTotFre, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Vlr. Frete', COL_VALFRE, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaValores(objCadMet.getMargem, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('% Margem', COL_MARGEM, strlinha, strMensagem);
    Exit;
  End;

  If (blnExibeCamposECMVBI) Then
  Begin
    If (Not fValidaValores(objCadMet.getAteDia, strMensagem)) Then
    Begin
      objValidaExcel.pIncluirErroCds('Meta Atend. Diário', COL_MTATDI, strlinha, strMensagem);
      Exit;
    End;

    If (Not fValidaValores(objCadMet.getTicMed, strMensagem)) Then
    Begin
      objValidaExcel.pIncluirErroCds('Meta Itens por Doc.', COL_MTTKMD, strlinha, strMensagem);
      Exit;
    End;

    If (Not fValidaValores(objCadMet.getIteDoc, strMensagem)) Then
    Begin
      objValidaExcel.pIncluirErroCds('Meta Ticket Médio', COL_MTITDC, strlinha, strMensagem);
      Exit;
    End;
  End;

  Result := True;
end;

end.