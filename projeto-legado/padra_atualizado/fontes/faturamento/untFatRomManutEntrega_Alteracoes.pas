unit untFatRomManutEntrega_Alteracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  MemDS, DBAccess, Uni;

type
  TfrmFatRomManutEntrega_Alteracoes = class(TfrmPai)
    dbeAlteracoes: TDBGridCitel;
    qryAlteracoes: TUniQuery;
    dscAlteracoes: TDataSource;
  private
    { Private declarations }
  public
    class procedure pMostrarRegistrosDeAlteracaoDaManutencaoDeEntrada(strAutInc, strTabela : String);
  end;

implementation

uses
  untFuncoesSimples, untModulo;

{$R *.dfm}

{ TfrmFatRomManutEntrega_Alteracoes }

class procedure TfrmFatRomManutEntrega_Alteracoes.pMostrarRegistrosDeAlteracaoDaManutencaoDeEntrada(strAutInc, strTabela: String);
var
  frmFatRomManutEntrega_Alteracoes: TfrmFatRomManutEntrega_Alteracoes;
  strTable : String;
  strField : String;
  str_SQL_ : String;
begin

  pCriarFormularios(TfrmFatRomManutEntrega_Alteracoes, frmFatRomManutEntrega_Alteracoes);

  Try

    If (strTabela = 'FATGOR') Then
    Begin
      strTable := 'OCOPED';
      strField := 'INCPED';
    End
    Else
    Begin
      strTable := IIF(strTabela = 'MOVGER', 'OCOGER', 'OCONOT');
      strField := IIF(strTabela = 'MOVGER', 'INCGER', 'INCNOT');
    End;

    str_SQL_ := '';
    str_SQL_ := str_SQL_ + 'SELECT ';
    str_SQL_ := str_SQL_ + '  DATE_FORMAT(O.OCO_DTAHOR,"%d/%m/%Y %T")      AS OCO_DTAHOR, ';
    str_SQL_ := str_SQL_ + '  CONCAT(O.OCO_CODOCO, "-", CADOCO.OCO_DESOCO) AS OCO_DESOCO, ';
    str_SQL_ := str_SQL_ + '  CONCAT(O.OCO_CODOPE, "-", CADOPE.OPE_NOMOPE) AS OPE_NOMOPE  ';
    str_SQL_ := str_SQL_ + 'FROM ' + strTable + ' AS O';
    str_SQL_ := str_SQL_ + '  INNER JOIN CADOCO ON (CADOCO.OCO_CODOCO = O.OCO_CODOCO) ';
    str_SQL_ := str_SQL_ + '  INNER JOIN CADOPE ON (CADOPE.OPE_CODOPE = O.OCO_CODOPE) ';
    str_SQL_ := str_SQL_ + 'WHERE O.OCO_' + strField + ' = ' + QuotedStr(strAutInc);
    str_SQL_ := str_SQL_ + '  ORDER BY O.OCO_DTAHOR ';

    frmFatRomManutEntrega_Alteracoes.qryAlteracoes.Close;
    frmFatRomManutEntrega_Alteracoes.qryAlteracoes.SQL.Clear;
    frmFatRomManutEntrega_Alteracoes.qryAlteracoes.SQL.Add(str_SQL_);
    frmFatRomManutEntrega_Alteracoes.qryAlteracoes.Open;

    If Not frmFatRomManutEntrega_Alteracoes.qryAlteracoes.IsEmpty Then
      frmFatRomManutEntrega_Alteracoes.ShowModal
    Else
      fMensagem('Atenção!', 'Nenhum registro de alteração encontrado!', ['&Ok']);

  Finally
    pFreeAndNil(frmFatRomManutEntrega_Alteracoes);
  End;

end;

end.
