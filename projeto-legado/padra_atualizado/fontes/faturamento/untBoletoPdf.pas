unit untBoletoPdf;

interface

  function fGerarBoletoPDF(strAutIncCadRec, strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;

implementation

uses
  untBoleto, untTypesSistema, untFuncoesSimples, System.SysUtils, Uni, UniClientDataSet;

function fGerarBoletoPDF(strAutIncCadRec, strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
var
  objDuplic: TArrDupCtr;
  objBoleto   : TBoleto;
  qryGenCtr   : TUniQuery;
  cdsBoleto   : TUniClientDataSet;
  intConta_   : Integer;
  strAutInc   : String;
  blnReimpressao: Boolean;
Begin
  Result := True;

  qryGenCtr := fCriaQuery;
  try
    Try
      blnReimpressao := True;
      strAutInc := '';

      SetLength(objDuplic, 1);
      objDuplic[Length(objDuplic) - 1].strNumDup := strNumDup;
      objDuplic[Length(objDuplic) - 1].strParcel := strParcel;
      objDuplic[Length(objDuplic) - 1].strCodEmp := strCodEmp;
      objDuplic[Length(objDuplic) - 1].strEspDoc := strEspDoc;
      objDuplic[Length(objDuplic) - 1].strCodCli := strCodCli;
      objDuplic[Length(objDuplic) - 1].strAutoIn := strAutIncCadRec;
      objDuplic[Length(objDuplic) - 1].blnAvisoAutomaticoEmail := True;

      For intConta_ := 0 To Length(objDuplic)-1 Do
        strAutInc := strAutInc + objDuplic[intConta_].strAutoIn + '", "';

      strAutInc := '"'+ strAutInc;
      strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

      qryGenCtr.Close;
      qryGenCtr.SQL.Clear;
      qryGenCtr.SQL.Text := TBoleto.fGetSQLBoletos(blnReimpressao);
      qryGenCtr.SQL.Text := StringReplace(qryGenCtr.SQL.Text, 'AUTINC', strAutInc, []);
      qryGenCtr.Open;

      objBoleto := TBoleto.Create(Nil, 'CADREC', False);
      cdsBoleto := fCriaClientDatset(qryGenCtr);

      objBoleto.pImprimir(cdsBoleto,
                          objDuplic,
                          cdsBoleto.FieldByName('CTR_BCOBOL').AsString,
                          False,
                          False,
                          True,
                          blnReimpressao,
                          False,
                          cdsBoleto.FieldByName('CTR_CARTEI').AsString,
                          '',
                          '',
                          '',
                          '',
                          '',
                          True,
                          False,
                          False,
                          False,
                          False,
                          False,
                          False,
                          False,
                          True);
    except
      Result := False;
    end;
  Finally
    If Assigned(cdsBoleto) Then
      FreeAndNil(cdsBoleto);

    If Assigned(objBoleto) Then
      FreeAndNil(objBoleto);

    If Assigned(objBoleto) Then
      FreeAndNil(qryGenCtr);
  End;

end;

end.
