unit untMovRcd;

interface

function fTemCotacaoVinculada(ANumeroRequisicao : string) : Boolean;
function fExisteRequisicaoDeCompraParaPedidoDeVenda(strNumDoc, strCodEmp, strEspDoc: String): Boolean;

implementation

uses Uni, System.Classes, untFuncoesSimples, SysUtils, untMemo, Data.DB;

function fTemCotacaoVinculada(ANumeroRequisicao : string) : Boolean;
Var
  LQuery : TUniQuery;
  stlMsg: TStringList;
  strDtaCad, strDtaFin: String;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Add('SELECT '+
                   '  COT_NUMCOT,'+
                   '  COT_DTACAD,'+
                   '  COT_DESCRI,'+
                   '  COT_DTAFIN '+
                   'FROM COTGER '+
                   'WHERE COT_CODEMP = :CODEMP AND'+
                   '  AUTOINCREM IN (SELECT COT_SEQGER'+
                   '                 FROM COTITE'+
                   '                   JOIN MOVRCD ON RCD_SEQCOT = COTITE.AUTOINCREM'+
                   '                 WHERE RCD_CODEMP = :CODEMP AND'+
                   '                   RCD_CODIGO = :CODIGO)');
    LQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQuery.ParamByName('CODIGO').AsString := ANumeroRequisicao;
    LQuery.Open;

    Result := Not LQuery.IsEmpty;

    If Result Then
    Begin
      stlMsg := TStringList.Create;
      Try
        stlMsg.Add('A Requisição de Compra não poderá ser excluída porque está vinculada às seguintes Cotações de Compra:');
        stlMsg.Add('');
        stlMsg.Add('Cotação-Data Cad.--Descrição---------------------------------------------------Encerramento');
        While Not LQuery.Eof Do
        Begin
          strDtaCad := FormatDateTime('dd/mm/yyyy', LQuery.FieldByName('COT_DTACAD').AsDateTime);
          If LQuery.FieldByName('COT_DTAFIN').AsDateTime > 0 Then
            strDtaFin := FormatDateTime('dd/mm/yyyy', LQuery.FieldByName('COT_DTAFIN').AsDateTime)
          Else
            strDtaFin := '';

          stlMsg.Add(fPadL(LQuery.FieldByName('COT_NUMCOT').AsString, 7, ' ')
              + ' '+ strDtaCad
              + ' '+ fPadR(LQuery.FieldByName('COT_DESCRI').AsString, 61, ' ')
              + ' '+ strDtaFin);
          LQuery.Next;
        End;
        stlMsg.Add('-------------------------------------------------------------------------------------------');

        TfrmMemo.pShowMessage(stlMsg, 9);
      Finally
        stlMsg.Free;
      End;
    End;

  Finally
    FreeAndNil(LQuery);
  End;

end;

function fExisteRequisicaoDeCompraParaPedidoDeVenda(strNumDoc, strCodEmp, strEspDoc: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)','MOVRCD',['RCD_DOCPDV','RCD_EMPPDV','RCD_ESPPDV'],[strNumDoc, strCodEmp, strEspDoc],False) > 0;
end;

end.
