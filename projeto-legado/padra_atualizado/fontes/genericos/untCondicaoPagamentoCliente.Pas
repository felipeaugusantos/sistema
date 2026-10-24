unit untCondicaoPagamentoCliente;

interface

uses uni, Forms, untFuncoesSimples, Classes, SysUtils;


  Type
    TCondicaoPagamentoCliente = record
      strCNDPAG: String;
      strCodCnd: String;
      strCodPor: String;
      strTIPFOR: String;
      intQtdCndPag: integer;
    procedure pCarregaDados(strCodClient: String; AstrCndPag: String);
  End;

implementation

uses
  untConsultas, untTypesSistema, untFuncoes;

{ TCondicaoPagamentoCliente }

procedure TCondicaoPagamentoCliente.pCarregaDados(strCodClient: String; AstrCndPag: String);
var qryConsulta: TUnIQuery;
    strConTmp: String;
    strConAux: String;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT COUNT(1)');
    qryConsulta.SQL.Add('  FROM CLICND');
    qryConsulta.SQL.Add('  LEFT JOIN CADCND ON CADCND.CND_CODIGO = CLICND.CND_CODCND');
    qryConsulta.SQL.Add(' WHERE CND_CODCLI = "'+strCodClient+'"');
    qryConsulta.Open;

    intQtdCndPag := qryConsulta.Fields[0].AsInteger;
    If intQtdCndPag = 0 Then
    Begin
      strCodCnd := '';
      strCodPor := '';
      strTipFor := '';
      strConTmp := '';
      Exit;
    End;

    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add('SELECT IFNULL(CADCND.CND_CNDPAG, CLICND.CND_CNDPAG) AS CND_CNDPAG,');
    qryConsulta.SQL.Add('       CLICND.CND_CODCND,');
    qryConsulta.SQL.Add('       CND_TIPFOR,');
    qryConsulta.SQL.Add('       CND_CODPOR');
    qryConsulta.SQL.Add('  FROM CLICND');
    qryConsulta.SQL.Add('  LEFT JOIN CADCND ON CADCND.CND_CODIGO = CLICND.CND_CODCND');
    qryConsulta.SQL.Add(' WHERE CND_CODCLI = "'+strCodClient+'"');
    If AstrCndPag <> '' Then
      qryConsulta.SQL.Add(' AND IFNULL(CADCND.CND_CNDPAG, CLICND. CND_CNDPAG) = "'+AstrCndPag+'"')
    Else
      qryConsulta.SQL.Add('  AND CND_SUGEST = "S"');

    qryConsulta.Open;

    If Not qryConsulta.IsEmpty then
    Begin
      strCodCnd := qryConsulta.FieldByname('CND_CODCND').AsString;
      strCodPor := qryConsulta.FieldByname('CND_CODPOR').AsString;
      strTipFor := qryConsulta.FieldByname('CND_TIPFOR').AsString;
      strConTmp := qryConsulta.FieldByname('CND_CNDPAG').AsString;

      If (fConPagFora(strTipFor)) Then
      Begin
        strCNDPAG := fRetCondicao('',
                                  0,
                                  strCodCnd,
                                  strTipFor,
                                  strConTmp,
                                  fNow,
                                  '',
                                  strCodClient);
        strConAux := strCNDPAG;
      End
      Else
        strCNDPAG := strConTmp;

      If (fEmptyStr(strConAux)) And (Pos(strTipFor, 'OUTROS_') <= 0) Then
        strConAux := fRetConPagCodCnd(strCodCnd)
      Else
        strConAux := strCNDPAG;

      strCNDPAG := fRetCondicaoDiaFixoCliente('',
                                              0,
                                              strCodClient,
                                              strConAux,
                                              fNow,
                                              '',
                                              '');

    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

end.
