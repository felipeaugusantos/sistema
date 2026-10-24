unit untEnderecosEntregaBaixaEntregaFutura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, UniClientDataSet, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, System.StrUtils;

type
  TfrmEnderecosEntregaBaixaEntregaFutura = class(TfrmPai)
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    dbgConsulta: TDBGridCitel;
  private
    { Private declarations }
    function fSQLFiltroMinimo: String;

  public
    { Public declarations }

    procedure pCarregaDados(const ADataEntrega: TDatetime; const ACodigoCliente,
      ACodigoCidade, ACodigoRegiao, AEndereco, ABairro: String);
  end;

implementation

uses
  untFuncoesSimples, Uni;

{$R *.dfm}

{ TfrmEnderecosEntregaBaixaEntregaFutura }

function TfrmEnderecosEntregaBaixaEntregaFutura.fSQLFiltroMinimo: String;
begin
  Result := ' D.DET_ESPDOC NOT IN ("ML", "PR", "TM", "TR", "BR", "PI", "EP") '
          + ' AND G.GER_ENTFUT = "S" ';

  If (fCfgSis('CONENT', varBoolean)) And (fCfgSis('COENFI', varBoolean)) Then
  Begin
    If ((fCfgSis('EMPGER', varBoolean))) Then
      Result := Result
              + ' AND ((G.GER_CONENT = "S") '
              + '  OR  (G.GER_CODEMP = ' + QuotedStr(fCfgSis('EMPMAT')) +')) '
    Else
    Begin
      Result := Result
              + ' AND G.GER_CONENT = "N" ';

      If fPermiteEmitirPedidoDeBaixaEntregaFuturaParaOutraLoja Then
        Result := Result
                + ' AND (D.DET_CODEMP = '+ QuotedStr(VS_strCodEmp)
                + '  OR T.DET_EMPORI = '+ QuotedStr(VS_strCodEmp) +')'
      Else
        Result := Result + ' AND G.GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
    End;
  End
  Else
  Begin
    If (fPermiteEmitirPedidoDeBaixaEntregaFuturaParaOutraLoja) Or (fCfgSis('FATSSA', varBoolean)) Then
      Result := Result
              + ' AND (D.DET_CODEMP = ' + QuotedStr(VS_strCodEmp)
              + '  OR T.DET_EMPORI = ' + QuotedStr(VS_strCodEmp) + ')'
    Else
      Result := Result
              + ' AND G.GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  End;

  If (fCfgSis('EFTEST') = '2') Then
  Begin
    Result := Result
            + ' AND (D.DET_PROEMB <> "S" OR T.DET_BXSBIT = "S") '
            + ' AND (D.DET_FILKAR = 0) ';
  End
  Else
    Result := Result
            + ' AND D.DET_PROEMB <> "S" ';
end;

procedure TfrmEnderecosEntregaBaixaEntregaFutura.pCarregaDados(
  const ADataEntrega: TDatetime; const ACodigoCliente, ACodigoCidade,
  ACodigoRegiao, AEndereco, ABairro: String);
var
  LQuery    : TUniQuery;
  LSqlWhere : String;
begin
  LQuery := fCriaQuery;
  Try
    LSqlWhere := ' WHERE D.DET_DTAFUT = '+QuotedStr(FormatDateTime('yyyy-mm-dd', ADataEntrega))
               + '   AND G.GER_CODCLI = '+QuotedStr(ACodigoCliente)
               + '   AND IFNULL(E.ETC_CIDENT,"") = '+QuotedStr(ACodigoCidade)
               + '   AND ' + fSQLFiltroMinimo;

    If (MatchStr(fCfgSis('AGBXEF'), ['3','4'])) Then
    Begin
      LSqlWhere := LSqlWhere
                 + '   AND IFNULL(E.ETC_CODREG,"") = '+QuotedStr(ACodigoRegiao);
    End;

    If (MatchStr(fCfgSis('AGBXEF'), ['4'])) Then
    Begin
      LSqlWhere := LSqlWhere
                 + '   AND IFNULL(E.ETC_ENDENT,"") = '+QuotedStr(AEndereco);
    End;

    If (MatchStr(fCfgSis('AGBXEF'), ['2','4'])) Then
    Begin
      LSqlWhere := LSqlWhere
                 + '   AND IFNULL(E.ETC_BAIENT,"") = '+QuotedStr(ABairro);
    End;

    LQuery.SQL.Text := 'SELECT '
                     + '       D.DET_DTAFUT '
                     + '     , G.GER_NUMDOC '
                     + '     , G.GER_ESPDOC '
                     + '     , G.GER_CODEMP '
                     + '     , CONCAT(IFNULL(E.ETC_ENDENT,""), ", ", IFNULL(E.ETC_BAIENT,""), " - ", IFNULL(I.CID_NOMCID,""), "-", IFNULL(I.CID_ESTADO,"")) AS ENDERECO '
                     + '  FROM MOVDET D '
                     + ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER '
                     + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
                     + '  LEFT JOIN ENTCLI E ON E.AUTOINCREM = A.AUX_ENTGER '
                     + '  LEFT JOIN CADCID I ON I.CID_CODCID = E.ETC_CIDENT '
                     + '  LEFT JOIN CADREG R ON R.REG_CODREG = E.ETC_CODREG '
                     + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM '
                     + LSqlWhere
                     + ' GROUP BY '
                     + '       D.DET_DTAFUT '
                     + '     , G.GER_NUMDOC '
                     + '     , G.GER_ESPDOC '
                     + '     , G.GER_CODEMP '
                     + ' ORDER BY '
                     + '       D.DET_DTAFUT '
                     + '     , G.GER_NUMDOC '
                     + '     , G.GER_ESPDOC '
                     + '     , G.GER_CODEMP ';

    LQuery.Open;
    pSetaClientDataSet(LQuery, cdsConsulta);
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
