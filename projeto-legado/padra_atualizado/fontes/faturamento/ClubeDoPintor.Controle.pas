unit ClubeDoPintor.Controle;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet, untFuncoesSimples,
{$ENDIF}
  System.Classes, System.SysUtils, System.StrUtils, System.DateUtils, Uni,
  Data.DB, System.Generics.Collections, ClubeDoPintor.Classes, untTypesSistema;

type
  TControleClubeDoPintor = class sealed
  private
    function fRetornaObjetoPontuarClubeDoPintor(const strNumDoc, strEspDoc,
      strCodEmp: String): TPontuar;
  public
    function fPontuarClubeDoPintor(const strOpcDoc, strNumDoc, strEspDoc,
      strCodEmp: String): Boolean;

    function fResgatarVoucherClubeDoPintor(const strVoucher,
      strOpcDoc: String; const blnPossuiBrinde: Boolean): Boolean;

    class function fPermiteUtilizarRotinaClubeDoPintor: Boolean;

  end;

implementation

uses
  ClubeDoPintor.Servico;

{ TControleClubeDoPintor }

function TControleClubeDoPintor.fRetornaObjetoPontuarClubeDoPintor(
  const strNumDoc, strEspDoc, strCodEmp: String): TPontuar;
var
  qryDados : TUniQuery;
begin
  If (Not fPermiteUtilizarRotinaClubeDoPintor) Or
     (Not MatchStr(strEspDoc, ARR_DOCUMENTOS_PONTUAR_CLUBE_DO_PINTOR)) Or
     (fEmptyStr(strNumDoc)) Or
     (fEmptyStr(strEspDoc)) or
     (fEmptyStr(strCodEmp)) Then
    Exit(nil);

  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT '
                       + '       MOVDET.AUTOINCREM '
                       + '     , MOVDET.DET_CODDIV '
                       + '     , CADDIV.DIV_NOMDIV '
                       + '     , CADDIV.DIV_C_G_C_ '
                       + '     , MOVDET.DET_NUMDOC '
                       + '     , MOVDET.DET_ESPDOC '
                       + '     , CADEMP.EMP_C_G_C_ '
                       + '     , CADITE.ITE_CODBAR '
                       + '     , MOVDET.DET_CODITE '
                       + '     , MOVDET.DET_DESCRI '
                       + '     , MOVDET.DET_QTDITE '
                       + '     , ROUND(MOVDET.DET_VLRCON / MOVDET.DET_QTDITE, 4) AS DET_UNITAR '
                       + '     , MOVDET.DET_VLRCON '
                       + '  FROM MOVDET '
                       + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = MOVDET.DET_CODITE '
                       + ' INNER JOIN CADDIV ON CADDIV.DIV_CODDIV = MOVDET.DET_CODDIV '
                       + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP '
                       + ' WHERE IFNULL(MOVDET.DET_CODDIV,"") <> "" '
                       + '   AND MOVDET.DET_NUMDOC = :NUMDOC '
                       + '   AND MOVDET.DET_ESPDOC = :ESPDOC '
                       + '   AND MOVDET.DET_CODEMP = :CODEMP '
                       + '   AND CADITE.ITE_CLBPIN = "S" '
                       + ' UNION '
                       + 'SELECT '
                       + '       NOTDET.AUTOINCREM '
                       + '     , NOTDET.DET_CODDIV '
                       + '     , CADDIV.DIV_NOMDIV '
                       + '     , CADDIV.DIV_C_G_C_ '
                       + '     , NOTDET.DET_NUMDOC '
                       + '     , NOTDET.DET_ESPDOC '
                       + '     , CADEMP.EMP_C_G_C_ '
                       + '     , CADITE.ITE_CODBAR '
                       + '     , NOTDET.DET_CODITE '
                       + '     , NOTDET.DET_DESCRI '
                       + '     , NOTDET.DET_QTDITE '
                       + '     , ROUND(NOTDET.DET_VLRCON / NOTDET.DET_QTDITE, 4) AS DET_UNITAR '
                       + '     , NOTDET.DET_VLRCON '
                       + '  FROM NOTDET '
                       + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = NOTDET.DET_CODITE '
                       + ' INNER JOIN CADDIV ON CADDIV.DIV_CODDIV = NOTDET.DET_CODDIV '
                       + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = NOTDET.DET_CODEMP '
                       + ' WHERE IFNULL(NOTDET.DET_CODDIV,"") <> "" '
                       + '   AND NOTDET.DET_NUMDOC = :NUMDOC '
                       + '   AND NOTDET.DET_ESPDOC = :ESPDOC '
                       + '   AND NOTDET.DET_CODEMP = :CODEMP '
                       + '   AND CADITE.ITE_CLBPIN = "S" '
                       + ' ORDER BY 1 ';

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit(nil);

    qryDados.First;

    Result := TPontuar.Create;
    Result.CnpjLoja           := qryDados.FieldByName('EMP_C_G_C_').AsString;
    Result.TipoFiscal         := 'NF';
    Result.IdentificadorVenda := qryDados.FieldByName('DET_NUMDOC').AsString;
    Result.CpfCliente         := qryDados.FieldByName('DIV_C_G_C_').AsString;
    Result.NomeCliente        := qryDados.FieldByName('DIV_NOMDIV').AsString;

    While Not qryDados.Eof Do
    Begin
      Result.Itens.Add(TItens.Create);
      Result.Itens.Items[Pred(Result.Itens.Count)].CodigoProduto := qryDados.FieldByName('ITE_CODBAR').AsString;
      Result.Itens.Items[Pred(Result.Itens.Count)].Qtde          := qryDados.FieldByName('DET_QTDITE').AsFloat;
      Result.Itens.Items[Pred(Result.Itens.Count)].ValorUnitario := qryDados.FieldByName('DET_UNITAR').AsFloat;
      Result.Itens.Items[Pred(Result.Itens.Count)].Valor         := qryDados.FieldByName('DET_VLRCON').AsFloat;

      qryDados.Next;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TControleClubeDoPintor.fPontuarClubeDoPintor(const strOpcDoc, strNumDoc,
  strEspDoc, strCodEmp: String): Boolean;
var
  objPontuar : TPontuar;
  objService : TServicoClubeDoPintor;
begin
  If (Not fPermiteUtilizarRotinaClubeDoPintor) Or
     (Not MatchStr(strEspDoc, ARR_DOCUMENTOS_PONTUAR_CLUBE_DO_PINTOR)) Or
     (Not MatchStr(strOpcDoc, ARR_OPCDOC_GERAR_VOUCHER_CLUBE_DO_PINTOR)) Then
    Exit(True);

  objPontuar := fRetornaObjetoPontuarClubeDoPintor(strNumDoc, strEspDoc, strCodEmp);
  If Not Assigned(objPontuar) Then
    Exit(True);

  objService := TServicoClubeDoPintor.Create;
  Try
    Try
      Result := objService.fPontuar(objPontuar);
    Except
      On E:Exception Do
      Begin
        Result := False;
        raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(objPontuar);
    FreeAndNil(objService);
  End;
end;

function TControleClubeDoPintor.fResgatarVoucherClubeDoPintor(
  const strVoucher, strOpcDoc: String; const blnPossuiBrinde: Boolean): Boolean;
var
  objResgatar : TResgatar;
  objService  : TServicoClubeDoPintor;
begin
  If (Not fPermiteUtilizarRotinaClubeDoPintor) Or
     (Not MatchStr(strOpcDoc, ARR_DOCUMENTOS_RESGATAR_CLUBE_DO_PINTOR)) Or
     (Not blnPossuiBrinde) Then
    Exit(True);

  objResgatar := TResgatar.Create;
  objService  := TServicoClubeDoPintor.Create;
  Try
    Try
      objResgatar.CodigoVoucher := strVoucher;

      Result := objService.fResgatar(objResgatar);
    Except
      On E:Exception Do
      Begin
        Result := False;
        raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(objResgatar);
    FreeAndNil(objService);
  End;
end;

class function TControleClubeDoPintor.fPermiteUtilizarRotinaClubeDoPintor: Boolean;
begin
  Result := (fCfgSis('CDPHAB', varBoolean));
end;

end.
