unit untGeraSpoolTransferencia;

interface

Uses
  Classes, UniClientDataSet, DB, SysUtils, Forms, Windows, Controls,
  Uni, cxProgressBar, StrUtils, untTypesSistema, untPreparaTEPedidoCompra,
  untFuncoesRel, untCadLote, untZClient, untFuncoesDllPedido,
  untGravando;

Type

  TGeraSpoolTransferencia = Class(TPreparaTEPedidoCompra)
  Private

    FMarcar: Boolean;

    Function fMarcarTodosPrg(prgProgresso: TCxprogressBar): Boolean;

  Public

    Constructor Create;  Overload;

    Destructor Destroy; Override;

    Procedure pMarcarTodos(blnMarcar: Boolean);

  Published

    Function fGeraItensGiro: Boolean;

    Procedure pMarcaDesmarca;

    Class Procedure pGeraSpool;

  End;


implementation

Uses
  Variants,
  untFuncoesSimples,
  untFuncoesPedidoSimples,
  untSpoolTransferenciaEdicao;

Constructor TGeraSpoolTransferencia.Create;
Begin
  inherited Create(True);

  cdsItensMult := TUniClientDataSet.Create(Nil);
  cdsItensPed  := TUniClientDataSet.Create(Nil);

  blnComDadosProduto := True;
End;

Destructor TGeraSpoolTransferencia.Destroy;
Begin
  inherited Destroy;

  FreeAndNil(cdsItensMult);
  FreeAndNil(cdsItensPed);
End;

Function TGeraSpoolTransferencia.fGeraItensGiro: Boolean;
  Var
    recDadGiro: TRecOpcoesGiro;
    oleItensMultiLojas: OleVariant;
begin
  Result := True;

  Try
    recDadGiro.strPedMlj := 'S';

    recDadGiro.opcChamada := chaSpoolTransferencia;

    recDadGiro.strNomFrm := 'frmDigGiroEstoqueSpool';

    cdsItensPed.Data  := fRetornaProdutosGiro(recDadGiro, oleItensMultiLojas);

    If (cdsItensPed.Data <> Null) And (cdsItensPed.RecordCount > 0) Then
    Begin

      Try
        cdsItensMult.Data  := oleItensMultiLojas;
        blnMtlCom          := recDadGiro.blnConsMCom;
        strEmpresasOrigens := recDadGiro.strEmpresasOrigens;
        blnMediaAjustada   := recDadGiro.blnMedAju;
        blnAgrupando       := Not fEmptyStr(recDadGiro.strEmpAgr);

        Result       := fGeraSpoolTransferencia(recDadGiro);

        If Result Then
        Begin
          pFiltraItensEdicao;

          If cdsItens.RecordCount > 0 Then
          Begin
            pCriarFormularios(TfrmSpoolTransferenciaEdicao, frmSpoolTransferenciaEdicao);

            frmSpoolTransferenciaEdicao.objSpool := Self;

            frmSpoolTransferenciaEdicao.ShowModal;

            pFreeAndNil(frmSpoolTransferenciaEdicao);
          End

          Else pMensagemOk('Nenhum item para transferir!');
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'fGeraItensGiro');
        End;
      End;

    End

    Else If recDadGiro.blnConfirmouExcecucao Then
           pMensagemOk('Nenhum item para transferir!');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'fGeraItensGiro');
    End;
  End;

end;

Class Procedure TGeraSpoolTransferencia.pGeraSpool;
  Var
    objSpool: TGeraSpoolTransferencia;
Begin
  objSpool := TGeraSpoolTransferencia.Create;

  objSpool.fGeraItensGiro;

  FreeAndNil(objSpool);
End;

Procedure TGeraSpoolTransferencia.pMarcarTodos(blnMarcar: Boolean);
Begin
  FMarcar := blnMarcar;

  TfrmGravando.fExecuta(fMarcarTodosPrg, frmGravando, IfThen(blnMarcar, 'Marcando registros', 'Desmancando resgistros'));
End;

Function TGeraSpoolTransferencia.fMarcarTodosPrg(prgProgresso: TCxprogressBar): Boolean;
Begin
  With cdsItens Do
  Try
    Result := True;

    DisableControls;


    Filter   := 'QTDANT > 0';
    Filtered := True;

    prgProgresso.Properties.Max := RecordCount;

    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('MARDES').AsString := IfThen(FMarcar, 'S', 'N');
      Post;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally

    EnableControls;

  End;

End;

Procedure TGeraSpoolTransferencia.pMarcaDesmarca;
Begin
  With cdsItens Do
  Begin

    Edit;
    FieldByName('MARDES').AsString := IfThen(FieldByName('MARDES').AsString = 'N', 'S', 'N');
    Post;

  End;

End;


end.

