unit untTLeitorRetornoCustodia033;

interface

uses
  System.Classes, System.Sysutils, untTProcessaRetornoCustodia;

type
  TLeitorRetornoCustodia033 = class(TLeitorRetornoCustodia)
  private
    function fDescrOcorr(strCodOco: String): String;
  public
    function fLerArquivo(strNomeArquivo: String; objProcessador: TProcessaRetornoCustodia): Boolean; override;
  end;

implementation

{ TLeitorRetornoCustodia033 }

uses untFuncoesSimples;

function TLeitorRetornoCustodia033.fDescrOcorr(strCodOco: String): String;
begin
  Result := '';
  If strCodOco = '05' Then Result := 'Cheques em carteira (em ser)';
  If strCodOco = '06' Then Result := 'Cheque depositado/enviado para compensação';
  If strCodOco = '07' Then Result := 'Cheque devolvido';
  If strCodOco = '09' Then Result := 'Cheque a ser depositado/enviado para a compensação na data boa';
  If strCodOco = '11' Then Result := 'Inclusão Confirmada';
  If strCodOco = '12' Then Result := 'Alteração Confirmada';
  If strCodOco = '13' Then Result := 'Exclusão Confirmada';
  If strCodOco = '14' Then Result := 'Sinistro Confirmado';
  If strCodOco = '21' Then Result := 'Inclusão Rejeitada';
  If strCodOco = '22' Then Result := 'Alteração Rejeitada';
  If strCodOco = '23' Then Result := 'Exclusão Rejeitada';
end;

function TLeitorRetornoCustodia033.fLerArquivo(strNomeArquivo: String;
  objProcessador: TProcessaRetornoCustodia): Boolean;
Var
  stlArquivo: TStringList;
  strLinha: String;
  objCheque: TChequeCustodia;
begin
  stlArquivo := TStringList.Create;
  Try
    stlArquivo.LoadFromFile(strNomeArquivo);
    For strLinha in stlArquivo Do
    Begin
      If Copy(strLinha, 14, 1) = 'D' Then
      Begin
        objCheque := TChequeCustodia.Create;

        objCheque.intStatus         := SOMENTE_NO_ARQUIVO;
        objCheque.strChave          := Copy(strLinha, 109, 20);
        objCheque.strLote           := Copy(strLinha, 4, 4);
        objCheque.strCodOcorrencia  := Copy(strLinha, 16, 2);
        objCheque.strDescOcorrencia := fDescrOcorr(Copy(strLinha, 16, 2));
        objCheque.strBanco          := Copy(strLinha, 22, 3);
        objCheque.strAgencia        := Copy(strLinha, 25, 4);
        objCheque.strNumConta       := Copy(strLinha, 43, 10);
        objCheque.strDvConta        := Copy(strLinha, 53, 1);
        objCheque.strNumCheque      := Copy(strLinha, 34, 6);
        objCheque.strCmc7           := Copy(strLinha, 21, 34);
        objCheque.strEmitente       := Copy(strLinha, 56, 14);
        objCheque.fltValor          := fStrToFloat(Copy(strLinha, 70, 13) + ',' + Copy(strLinha, 83, 2));
        objCheque.dtaCadastro       := StrToDate(Copy(strLinha, 85, 2) + '/' + Copy(strLinha, 87, 2) + '/' + Copy(strLinha, 89, 4));
        objCheque.dtaVencimento     := StrToDate(Copy(strLinha, 93, 2) + '/' + Copy(strLinha, 95, 2) + '/' + Copy(strLinha, 97, 4));
        if StrToIntDef(Copy(strLinha, 93, 2), 0) > 0 Then
          objCheque.dtaDeposito       := StrToDate(Copy(strLinha, 93, 2) + '/' + Copy(strLinha, 95, 2) + '/' + Copy(strLinha, 97, 4));
        if StrToIntDef(Copy(strLinha, 101, 2), 0) > 0 Then
          objCheque.dtaCredito        := StrToDate(Copy(strLinha, 101, 2) + '/' + Copy(strLinha, 103, 2) + '/' + Copy(strLinha, 105, 4));

        objProcessador.pInsereCheque(objCheque);
      End;
    End;

    Result := True;
  Finally
    FreeAndNil(stlArquivo);
  End;
end;

initialization

  RegisterClass(TLeitorRetornoCustodia033);

end.
