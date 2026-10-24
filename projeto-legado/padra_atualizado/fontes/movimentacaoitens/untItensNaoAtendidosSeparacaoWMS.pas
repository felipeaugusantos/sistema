unit untItensNaoAtendidosSeparacaoWMS;

interface

Uses System.SysUtils, System.Generics.Collections, untFuncoesSimples, Uni;

Type
  TDadosItem = Class
  Private
    FCodIte : String;
    FDesIte : String;
    FNumDoc : String;
    FEspDoc : String;
    FQtdPed : Double;
    FQtdDis : Double;
  Public
    Property strCodIte : String Read FCodIte Write FCodite;
    Property strDesIte : String Read FDesIte Write FDesIte;
    Property strNumDoc : String Read FNumDoc Write FNumDoc;
    Property strEspDoc : String Read FEspDoc Write FEspDoc;
    Property fltQtdPed : Double Read FQtdPed Write FQtdPed;
    Property fltQtdDis : Double Read FQtdDis Write FQtdDis;
  End;

Type
  TItensNaoAtendidosSeparacaoWMS = Class
  Private
    lstDadosItem : TObjectList<TDadosItem>;
    class var Instance : TItensNaoAtendidosSeparacaoWMS;
    class function getInstance : TItensNaoAtendidosSeparacaoWMS;

    Constructor Create;
    function fRetResumoLotes: String;
  Public
    class procedure pAdd(strCodIte, strDesIte, strNumDoc, strEspDoc : String; fltQtdPed, fltQtdDis : Double);
    class procedure pLimpar;
    class procedure pExibeItens;
    class function isEmpty : Boolean;
  End;

implementation

uses
  untMemo, untDefineLotesWMS, untConstantes;

{ TItensNaoAtendidosSeparacaoWMS }

constructor TItensNaoAtendidosSeparacaoWMS.Create;
begin
  lstDadosItem := TObjectList<TDadosItem>.Create;
end;

class procedure TItensNaoAtendidosSeparacaoWMS.pExibeItens;
  function fRetLinha(strCodIte, strDesIte, strNumDoc, strEspDoc, strQtdPed, strQtdDis : String):String;
  Begin
    Result := fPadR(strCodIte, IIF(fTamcodite=5,6,7)) + ' ' +
              fPadR(strDesIte, 30) + ' ' +
              fPadR(strNumDoc, 12) + ' ' +
              fPadR(strEspDoc, 02) + ' ' +
              fPadL(strQtdPed, 16) + ' ' +
              fPadL(strQtdDis, 16);
  End;

  Var
    strMensag: String;
    intIndex : Integer;
begin
  With getInstance Do
  Begin

    if (not isEmpty) Then
    Begin
      strMensag := 'Não foi possível atender os itens abaixo por falta de estoque, a Separacao não será impressa!' + #13;
      strMensag := strMensag + fRetLinha('Código', 'Descrição', 'Documento', '', 'Qtde. Doc.', 'Qtde. Disponível') + #13;

      For intIndex := 0 To lstDadosItem.Count -1 Do
      Begin
        strMensag := strMensag + fRetLinha(lstDadosItem.Items[intIndex].strCodIte,
                                           lstDadosItem.Items[intIndex].strDesIte,
                                           lstDadosItem.Items[intIndex].strNumDoc,
                                           lstDadosItem.Items[intIndex].strEspDoc,
                                           FormatFloat('#,##0.00', lstDadosItem.Items[intIndex].fltQtdPed),
                                           FormatFloat('#,##0.00', lstDadosItem.Items[intIndex].fltQtdDis)) + #13;

      End;

      strMensag := strMensag + #13 + #13 + 'RESUMO DOS LOTES DOS ITENS NÃO ATENDIDOS' + #13 + fRetResumoLotes;


      fLock_Unlock(STR_DEFINICAO_LOTES, False);
      TfrmMemo.pShowMessage(strMensag, 10, False, 900);

    End;
  End;
end;

function TItensNaoAtendidosSeparacaoWMS.fRetResumoLotes : String;

  function fRetLinha(strCodIte, strDesIte, strLocFis, strPickin, strCritic, strStatus, strSalDis : String; blnTitulo : Boolean = False):String;
  Begin
    If not blnTitulo Then
    Begin
      if strPickin = 'S' Then
        strPickin := 'Sim'
      Else
        strPickin := 'Não';

      If strCritic = 'S' Then
        strCritic := 'Sim'
      Else
        strCritic := 'Não';

      If strStatus = 'S' Then
        strStatus := 'Ativo'
      Else
      If strStatus = 'N' Then
        strStatus := 'Inativo'
      Else
        strStatus := 'Bloqueado';

    End;

    Result := fPadR(strCodIte, IIF(fTamcodite=5,6,7)) + ' ' +
              fPadR(strDesIte, 30) + ' ' +
              fPadR(strLocFis, 15) + ' ' +
              fPadR(strPickin, 07) + ' ' +
              fPadR(strCritic, 07) + ' ' +
              fPadR(strStatus, 09) + ' ' +
              fPadL(strSalDis, 16);
  End;


  Var
    strItensJaProcessados : String;
    qryCadLot : TUniQuery;
    intIndex  : Integer;
Begin
  Try
    strItensJaProcessados := '';
    qryCadLot := fCriaQuery;
    With qryCadLot, SQL Do
    Begin
      Close;
      Clear;
      Add( TDefineLotesWMS.fGetSqlLotes );
      Add( 'ORDER BY IF(LOC_PICKIN = "S",0,1) ');

      Result:= fRetLinha('Código', 'Descrição', 'Loc. Física', 'Picking', 'Critico', 'Status', 'Saldo Disp.', True) + #13;

      For intIndex := 0 To lstDadosItem.Count -1 Do
      Begin
        If Pos(lstDadosItem.Items[intIndex].strCodIte, strItensJaProcessados) = 0 Then
        Begin
          strItensJaProcessados := strItensJaProcessados + lstDadosItem.Items[intIndex].strCodIte + '_';

          Close;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODITE').AsString := lstDadosItem.Items[intIndex].strCodIte;
          ParamByName('BROKER').AsString := 'N';
          Open;

          While Not Eof Do
          Begin
            Result := Result + fRetLinha(lstDadosItem.Items[intIndex].strCodIte,
                                         lstDadosItem.Items[intIndex].strDesIte,

                                         FieldByName('LOT_LOCFIS').AsString,
                                         FieldByName('LOC_PICKIN').AsString,
                                         FieldByName('LOC_CRITIC').AsString,
                                         FieldByName('LOT_STATUS').AsString,
                                         FormatFloat('#,##0.00', fRetornaSaldoDisponivel(lstDadosItem.Items[intIndex].strCodIte, False, True, FieldByName('LOT_NUMLOT').AsString))) + #13;

            Next;
          End;

          Result := Result + #13;

        End;

        //strMensag := strMensag + fRetLinha(lstDadosItem.Items[intIndex].strCodIte,
      End;

    End;
  Finally
    FreeAndNil(qryCadLot);
  End;

End;

class function TItensNaoAtendidosSeparacaoWMS.getInstance: TItensNaoAtendidosSeparacaoWMS;
begin
  If Assigned(Instance) Then
    Exit(Instance);

  Instance := TItensNaoAtendidosSeparacaoWMS.Create;
  Result := Instance;
end;


class function TItensNaoAtendidosSeparacaoWMS.isEmpty: Boolean;
begin
  Result := getInstance.lstDadosItem.Count = 0;
end;

class procedure TItensNaoAtendidosSeparacaoWMS.pAdd(strCodIte, strDesIte, strNumDoc,  strEspDoc: String; fltQtdPed, fltQtdDis: Double);
  Var
    objItem : TDadosItem;
begin
  With TItensNaoAtendidosSeparacaoWMS.getInstance Do
  Begin
    objItem := TDadosItem.Create;
    objItem.strCodIte := strCodIte;
    objItem.strDesIte := strDesIte;
    objItem.strNumDoc := strNumDoc;
    objItem.strEspDoc := strEspDoc;
    objItem.fltQtdPed := fltQtdPed;
    objItem.fltQtdDis := fltQtdDis;

    lstDadosItem.Add(objItem);
  End;

end;

class procedure TItensNaoAtendidosSeparacaoWMS.pLimpar;
begin
  If Assigned(Instance) Then
  Begin
    Instance.lstDadosItem.Clear;
    FreeAndNil(Instance.lstDadosItem);
    FreeAndNil(Instance);
  End;
end;

end.
