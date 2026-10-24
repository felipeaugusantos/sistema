unit Faturamento.View.ConsultaCTe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmFatConsultaCTe = class(TfrmPaiOrdena)
    btnAlterar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function fCTeSemErroTransmissao(strTabela, strNumCTe, strCodEmp: string): Boolean;
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
  end;

implementation

{$R *.dfm}

uses Faturamento.View.DadosCTe, untFuncoesSimples;

{ TfrmFatConsultaCTe }

procedure TfrmFatConsultaCTe.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if cdsConsulta.IsEmpty then
    Exit;

  if (fCTeSemErroTransmissao(cdsConsulta.FieldByName('TABELA').AsString,
                  cdsConsulta.FieldByName('CTE_NUMCTE').AsString,
                  cdsConsulta.FieldByName('CTE_CODEMP').AsString)) then
  begin
    fMensagem('ATENÇÃO!', 'Este CTe não pode ser alterado! Consulte o PainelNFE!', ['&O k']);
    Exit;
  end;

  TfrmFatDadosCTe.Alterar(
    cdsConsulta.FieldByName('TABELA').AsString,
    cdsConsulta.FieldByName('CTE_NUMCTE').AsString,
    cdsConsulta.FieldByName('CTE_CODEMP').AsString);
end;

procedure TfrmFatConsultaCTe.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnAlterar.Click;
end;

function TfrmFatConsultaCTe.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
end;

function TfrmFatConsultaCTe.fCTeSemErroTransmissao(strTabela, strNumCTe, strCodEmp: string): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  CTE_NUMCTE ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  ' + strTabela + ' ');
    qryAux.SQL.Add('  INNER JOIN LOGNFE ON CTE_NUMCTE = NFE_NUMDOC ');
    qryAux.SQL.Add('                   AND NFE_ESPDOC = "CT" ');
    qryAux.SQL.Add('                   AND CTE_CODEMP = NFE_CODEMP ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  IFNULL(CTE_ACESSO, "") = "" ');
    qryAux.SQL.Add('  AND IFNULL(NFE_STATUS, "") = "CE" ');
    qryAux.SQL.Add('  AND CTE_NUMCTE = :NUMCTE ');
    qryAux.SQL.Add('  AND CTE_CODEMP = :CODEMP ');

    qryAux.ParamByName('NUMCTE').AsString := strNumCTe;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;

    Result := qryAux.IsEmpty;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmFatConsultaCTe.fGetSql(blnLike: Boolean): String;
Var
  strSQL: String;
begin
  strSQL := strSQL + ' SELECT';
  strSQL := strSQL + '   TABELA,';
  strSQL := strSQL + '   CTE.AUTOINCREM,';
  strSQL := strSQL + '   CTE_CODEMP,';
  strSQL := strSQL + '   CTE_NUMCTE,';
  strSQL := strSQL + '   CTE_DTAEMI,';
  strSQL := strSQL + '   CAST(NFE_OBSERV AS CHAR(500)) AS NFE_OBSERV';
  strSQL := strSQL + ' FROM (';

  strSQL := strSQL + '   SELECT';
  strSQL := strSQL + '     "MOVCTE" AS TABELA,';
  strSQL := strSQL + '     MOVCTE.*';
  strSQL := strSQL + '   FROM MOVCTE';

  strSQL := strSQL + '   UNION ALL ';

  strSQL := strSQL + '   SELECT';
  strSQL := strSQL + '     "NOTCTE" AS TABELA,';
  strSQL := strSQL + '     NOTCTE.*';
  strSQL := strSQL + '   FROM NOTCTE';
  strSQL := strSQL + ' ) AS CTE';

  strSQL := strSQL + '  INNER JOIN LOGNFE';
  strSQL := strSQL + '     ON NFE_NUMDOC = CTE_NUMCTE';
  strSQL := strSQL + '    AND NFE_ESPDOC = "CT"';
  strSQL := strSQL + '    AND NFE_CODEMP = CTE_CODEMP';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    IFNULL(CTE_ACESSO, "") = "" ';
  strSQL := strSQL + '    AND IFNULL(NFE_STATUS, "") = "CE" ';
  strSQL := strSQL + '    AND CTE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + fFiltraSQL(blnlike);

  Result := strSQL;
end;

procedure TfrmFatConsultaCTe.FormShow(Sender: TObject);
begin
  inherited;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;
  fAbreConsulta(TRUE);
end;

end.
