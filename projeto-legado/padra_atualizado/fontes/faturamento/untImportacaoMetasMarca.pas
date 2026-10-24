unit untImportacaoMetasMarca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untImportacaoMetas, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, Data.DB, DBAccess, Uni, frxClass, Datasnap.DBClient, UniClientDataSet,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ComCtrls,
  cxProgressBar, cxButtons, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  untMetMarController, untMetMar;

type
  TfrmImportacaoMetasMarca = class(TfrmImportacaoMetas)
    cdsDadosMET_CODMAR: TStringField;
    cdsDadosMET_PERMAR: TFloatField;
    cdsDadosAUTOINCREM: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsDadosAfterOpen(DataSet: TDataSet);
  private
    objController: TMetMarController;

    Const
      QTDCOLUM = 5;

      COL_CODMAR = 'D';
      COL_PERMAR = 'E';

      DES_CODMAR = 'Código Marca';
      DES_PERMAR = 'Percentual';

    function fValidaDadosLinha(Const objMetMar: TMetMar; intLinha: Integer): Boolean;
    function fValidaCodMar(strCodigo, strCodVen, strMesAno: String; var strMensagem: String): Boolean;
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

procedure TfrmImportacaoMetasMarca.FormCreate(Sender: TObject);
begin
  inherited;
  intQtdColunas := QTDCOLUM;
  objController := TMetMarController.Create;
end;

procedure TfrmImportacaoMetasMarca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objController);
end;

procedure TfrmImportacaoMetasMarca.pMontaObjValidadorComplementar;
begin
  inherited;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODMAR, COL_CODMAR, 0, False, False, '', '', False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_PERMAR, COL_PERMAR, 0, False, False, '', '', False));
end;

procedure TfrmImportacaoMetasMarca.pPreencheCdsDados(intLinha: Integer);
  Var
    objMetMar: TMetMar;
begin
  inherited;
  objMetMar := TMetMar.Create('',
                              cdsDados.FieldByName('MET_CODEMP').AsString,
                              cdsDados.FieldByName('MET_MESANO').AsString,
                              cdsDados.FieldByName('MET_CODVEN').AsString,
                              objValidaExcel.fGetValueCSV(intLinha, COL_CODMAR),
                              StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_PERMAR), 0));
  Try
    If (Not fValidaDadosLinha(objMetMar, intLinha)) Then
    Begin
      cdsDados.Delete;
      Exit;
    End;

    cdsDados.Edit;
    cdsDados.FieldByName('MET_CODMAR').AsString := objMetMar.getCodMar;
    cdsDados.FieldByName('MET_PERMAR').AsFloat  := objMetMar.getPerMar;
    cdsDados.Post;
  Finally
    FreeAndNil(objMetMar);
  End;
end;

procedure TfrmImportacaoMetasMarca.cdsDadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pFormataCampoFloat('MET_PERMAR');
end;

function TfrmImportacaoMetasMarca.fValidaCodMar(strCodigo, strCodVen, strMesAno: String; Var strMensagem: String): Boolean;
  Const
    CODMAR = 'MAR_CODMAR';
    ATIVA_ = 'MAR_ATIVA_';
    TABELA = 'CADMAR';

  Var
    intRecNo: Integer;
begin
  Result := False;
  intRecNo := cdsDados.RecNo;

  If (Not fValidaCodigo(TABELA, [CODMAR, ATIVA_], [strCodigo, 'S'], strMensagem)) Then
    Exit;

  If (cdsDados.FindKey([strMesAno, strCodVen, strCodigo])) Then
  Begin
    cdsDados.RecNo := intRecNo;
    strMensagem := 'Marca '+ strCodigo + ' já inserida';
    Exit;
  End;

  cdsDados.RecNo := intRecNo;
  Result := True;
end;

function TfrmImportacaoMetasMarca.fGravar: Boolean;
begin
  Result := objController.fGravarColecao(cdsDados);
end;

function TfrmImportacaoMetasMarca.fValidaPercentuais(cdsClone: TUniClientDataSet;
  strMesAno, strCodVen, strFiltro: String): Boolean;
begin
  Result := fValidaSomaPercentuais(cdsClone, strMesAno, strCodVen, strFiltro, 'MET_PERMAR', COL_PERMAR);
end;

function TfrmImportacaoMetasMarca.fValidaDadosLinha(Const objMetMar: TMetMar; intLinha: Integer): Boolean;
  Var
    strMensagem: String;
    strLinha: String;
begin
  Result := False;
  strlinha := IntToStr(intLinha + 1);

  If (Not fValidaCodMar(objMetMar.getCodMar, objMetMar.getCodVen, objMetMar.getMesAno, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Código Marca', COL_CODMAR, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaPercentual(objMetMar.getPerMar, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Percentual', COL_PERMAR, strlinha, strMensagem);
    Exit;
  End;

  Result := True;
end;

end.
