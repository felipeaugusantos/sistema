unit OrdemProducaoIndustrial.Funcoes;

interface

uses
  Math,
  SysUtils,
  Data.DB;

  function fRetornaSugestaoMaximaProducao(fltPesoTotalDisponivel, fltPesoUnitario : real) : integer;
  function fRetornaValorArredondado(fltValor : double) : double;

  function fConverteKiloParaLitro(fltPesoReal, fltKilo  : double) : double;
  function fConverteLitroParaKilo(fltPesoReal, fltLitro : double) : double;

  procedure pCalculaPesoEspecificoSubItens(cdsDados: TDataSet;
                                           Var intMaxSeqGer: Integer;
                                           Var fltTotPercen,
                                               fltTotCusIte,
                                               fltTotDensid,
                                               fltPVC,
                                               fltCPVC,
                                               fltPVCCPVC,
                                               fltMassaSolidos,
                                               fltVolumeSolidos: Double;
                                            blnDesenvFormulas: Boolean = False);
function fCalculaPVC(fltQtdCarga, fltVolumeSolidosResina, fltPVC: Double): Double;

implementation

function fRetornaSugestaoMaximaProducao(fltPesoTotalDisponivel, fltPesoUnitario : real) : integer;
begin
   if fltPesoTotalDisponivel > 0 then
    Result := Floor(fltPesoTotalDisponivel / fltPesoUnitario)
  else
    Result := 0;
end;


function fRetornaValorArredondado(fltValor : double) : double;
begin
  Result := RoundTo(fltValor, -4);
end;

function fConverteKiloParaLitro(fltPesoReal, fltKilo : double) : double;
begin

  if fltPesoReal = 0 then
    raise Exception.Create('O peso real deve ser maior que zero!');

  Result := fltKilo / fltPesoReal;
  Result := fRetornaValorArredondado(Result);
end;

function fConverteLitroParaKilo(fltPesoReal, fltLitro : double) : double;
begin

  if fltPesoReal = 0 then
    raise Exception.Create('O peso real deve ser maior que zero!');

  Result := fltLitro * fltPesoReal;
  Result := fRetornaValorArredondado(Result);
end;

procedure pCalculaPesoEspecificoSubItens(cdsDados: TDataSet;
                                         Var intMaxSeqGer: Integer;
                                         Var fltTotPercen,
                                             fltTotCusIte,
                                             fltTotDensid,
                                             fltPVC,
                                             fltCPVC,
                                             fltPVCCPVC,
                                             fltMassaSolidos,
                                             fltVolumeSolidos: Double;
                                         blnDesenvFormulas: Boolean = False);

  Var
    fltQtdCarga,
    fltTotalSolidos,
    fltVolumeSolidosResina,
    fltTotalAbsOle: Double;
Begin
  intMaxSeqGer := 0;
  fltTotPercen := 0;
  fltTotCusIte := 0;
  fltTotDensid := 0;

  fltPVC           := 0;
  fltCPVC          := 0;
  fltPVCCPVC       := 0;
  fltQtdCarga      := 0;
  fltTotalSolidos  := 0;
  fltTotalAbsOle   := 0;
  fltMassaSolidos  := 0;
  fltVolumeSolidos := 0;
  fltVolumeSolidosResina := 0;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin

    If blnDesenvFormulas Then
    Begin
      fltTotalAbsOle  := Sum([fltTotalAbsOle,  cdsDados.FieldByName('DMT_QTDITE').AsFloat * (cdsDados.FieldByName('ITE_ABSOLE').AsFloat / 100)]);
      fltMassaSolidos := Sum([fltMassaSolidos, cdsDados.FieldByName('DMT_QTDITE').AsFloat * (cdsDados.FieldByName('ITE_PERSOL').AsFloat / 100)]);
    End;

    intMaxSeqGer := Max( intMaxSeqGer, cdsDados.FieldByName('DMT_SEQUEN').AsInteger );
    fltTotPercen := Sum([fltTotPercen, cdsDados.FieldByName('DMT_QTDITE').AsFloat  ]);

    fltTotCusIte := Sum([fltTotCusIte,
                         fRetornaValorArredondado(cdsDados.FieldByName('DMT_CUSITE').AsFloat *
                         cdsDados.FieldByName('DMT_QTDITE').AsFloat / 100)]);

    If cdsDados.FieldByName('DMT_DENSID').AsFloat <> 0 Then
    Begin
      fltTotDensid := Sum([fltTotDensid,
                           cdsDados.FieldByName('DMT_QTDITE').AsFloat /
                           cdsDados.FieldByName('DMT_DENSID').AsFloat ]);

      If blnDesenvFormulas Then
      Begin

        If cdsDados.FieldByName('ITE_ECARGA').AsString = '1' Then
        Begin
          fltQtdCarga := Sum([fltQtdCarga,
                             cdsDados.FieldByName('DMT_QTDITE').AsFloat /
                             cdsDados.FieldByName('DMT_DENSID').AsFloat ]);

        End
        Else If cdsDados.FieldByName('ITE_ECARGA').AsString = '2' Then
        Begin
          fltVolumeSolidosResina := Sum([fltVolumeSolidosResina,
                                        (cdsDados.FieldByName('DMT_QTDITE').AsFloat * (cdsDados.FieldByName('ITE_PERSOL').AsFloat / 100)) /
                                        cdsDados.FieldByName('DMT_DENSID').AsFloat ]);
        End;

        fltTotalSolidos := Sum([fltTotalSolidos,
                               (cdsDados.FieldByName('DMT_QTDITE').AsFloat * (cdsDados.FieldByName('ITE_PERSOL').AsFloat / 100)) /
                               cdsDados.FieldByName('DMT_DENSID').AsFloat ]);
      End;

    End;

    cdsDados.Next;
  End;

  If fltTotDensid > 0 Then
    fltTotDensid := fltTotPercen / fltTotDensid;


  fltPVC := fCalculaPVC(fltQtdCarga, fltVolumeSolidosResina, fltPVC);

  If (fltQtdCarga + fltTotalAbsOle) <> 0 Then
    fltCPVC := (fltQtdCarga / (fltQtdCarga + fltTotalAbsOle)) * 100;

  If fltCPVC <> 0 Then
    fltPVCCPVC := fltPVC / fltCPVC;

  If fltTotDensid > 0 Then
    fltVolumeSolidos := (fltTotalSolidos * 100) / ( 100 / fltTotDensid);
End;

function fCalculaPVC(fltQtdCarga, fltVolumeSolidosResina, fltPVC: Double): Double;
begin
  result := fltPVC;
  If (fltQtdCarga + fltVolumeSolidosResina) <> 0 Then
    result := (fltQtdCarga / (fltQtdCarga + fltVolumeSolidosResina)) * 100;

End;

end.

