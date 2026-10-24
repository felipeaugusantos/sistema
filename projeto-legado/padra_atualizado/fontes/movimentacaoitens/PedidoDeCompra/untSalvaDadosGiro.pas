unit untSalvaDadosGiro;

interface

uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, untZClient,
  StrUtils, Math, untFuncoesSimples, ExtCtrls, StdCtrls, EditFocus, MaskEditFocus,
  CheckLst, Uni, untSalvaDadosInterface, untTypesSistema, untTEditFocusWithTConsultasArray;

Type
  TSalvaInterfaceGiro = Class(TSalvaInterface)

  Private
    strCodVendedor: string;
    strCodDigitador : string;
    strComprador: string;
    blnUsaDigitador: Boolean;

  Public
    blnEmpVis: Boolean;

    blnEncontrouGiro: Boolean;

    blnExibiItens: Boolean;

    constructor Create(Owner: TComponent);

    Function fCarregaDados(strValKey: String; frmForm: TForm; strNomFrm: String = ''; strCodOpe: String = '';
                           blnRecuperandoPedido: Boolean = False; blnCarregaTela: Boolean = True): Boolean; Reintroduce;

    Function fAtualizaDados: Boolean; Override;

    Function fSalvaDados(strValKey: String;
                         strNomFrm: String = '';
                         strCodOpe: String = '';
                         blnAtualizaDados: Boolean = False;
                         arrCampos: TArrString = Nil;
                         strNomeTabela: String = 'CADINT'): Boolean; override;

    Function fSalvaDadosDesmembrado(strValKey, strNomFrm, strCodEmp: String; strCodOpe: String = ''): Boolean;

    Procedure pSetaFiltro(strNomeFiltro, strValor: String);

    Class Function fApagaInterfacePedido(strValKey: String; strCodOpe: String = ''): Boolean;
    Class Function fApagaInterfaceCotacao(strValKey: String; strCodOpe: String = ''): Boolean;

  End;

implementation

Uses
  untDigGiroEstoque;

constructor TSalvaInterfaceGiro.Create(Owner: TComponent);
Begin
  Inherited;
  strCodVendedor := '';
  strComprador   := '';
  strCodDigitador:= '';
  blnExibiItens  := True;
  blnUsaDigitador:= fCfgSis('DIGCOT', varBoolean);
  blnDeleteNaoEncontrados := False;

  blnEmpVis := fCfgSis('EMPVIS', varBoolean);
End;

Function TSalvaInterfaceGiro.fAtualizaDados: Boolean;
  Var
    stlLista: TStringList;
    cdsDados: TDataSet;

    Procedure pTrataEmpresas(strCampo: String);
      Var
        strLojas,
        strBusca: String;
    Begin
      With frmDigGiroEstoque Do
      Begin
        stlLista.Clear;
        strLojas := '';

        If SameText(strCampo, 'MARDES') Then
        Begin
          strBusca := cxGrid.Name
        End Else
        Begin
          strBusca := strCampo;

          If strPedMlj <> 'S' Then
          Begin
            pLocalizaRegistro('MARDES');
            strLojas := FieldByName('INT_VALCOM').AsString;
          End;
        End;

        If SameText(strCampo, 'EMPTRA') Then
        Begin
          strBusca := strCampo;
          pLocalizaRegistro('EMPTRA');
          strLojas := FieldByName('INT_VALCOM').AsString;
        End;


        pLocalizaRegistro(strBusca);

        If SameText('EMPVIS', strCampo) And (Not blnEmpVis) Then
        Begin

          stlLista.Clear;

        End


        Else
        Begin
          If Not SameText(strCampo, 'EMPTRA') Then
          Begin
            cdsDados := cxvEmpresas.DataController.DataSource.DataSet;
            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              If cdsDados.FieldByName(strCampo).AsString = 'S' Then
                stlLista.Add(cdsDados.FieldByName('CODEMP').AsString);

              cdsDados.Next;
            End;
          End
          Else
          Begin
            strCampo := 'MARDES';
            stlLista.Clear;
            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              If cdsDados.FieldByName(strCampo).AsString = 'M' Then
                stlLista.Add(cdsDados.FieldByName('EMP_CODEMP').AsString);

              cdsDados.Next;
            End;
          End;

        End;

        If (strPedMlj <> 'S') And SameText('EMPVIS', strCampo) Then
          FieldByName('INT_VALCOM').AsString := strLojas
        Else
          FieldByName('INT_VALCOM').AsString := stlLista.Text;

        Post;
      End;
    End;

    Procedure pTrataMeses;
    Begin
      With frmDigGiroEstoque, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        stlLista.Clear;
        pLocalizaRegistro(lblSelMes.Name);

        If chkInfMes.Checked Then
        Begin
          FieldByName('INT_VALCOM').AsString := strMeses;

          Post;
        End Else
        Begin

          If State = dsInsert Then
          Begin
            Cancel;
          End Else
          Begin
            Cancel;
            Delete;
          End;

        End;
      End;
    End;

    Procedure pTrataNiveis;
    Begin
      With frmDigGiroEstoque, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        stlLista.Clear;

        pLocalizaRegistro(cxgNivel.Name);

        cdsDados := cxvNivel.DataController.DataSource.DataSet;

        cdsDados.First;
        While Not cdsDados.Eof Do
        Begin
          stlLista.Add(cdsDados.FieldByName('NIVGIR').AsString + ';' +
                       cdsDados.FieldByName('USANIV').AsString + ';' +
                       cdsDados.FieldByName('QTDDIA').AsString + '/' +
                       cdsDados.FieldByName('PERCON').AsString);

          cdsDados.Next;
        End;

        FieldByName('INT_VALCOM').AsString := stlLista.Text;

        Post;
      End;
    End;

Begin
  Try
    Result := inherited;

    If Result Then
    Begin

      If Assigned(frmDigGiroEstoque) Then
      With frmDigGiroEstoque Do
      Begin
        stlLista := TStringList.Create;

        pTrataEmpresas('MARDES');
        pTrataEmpresas('EMPVIS');
        cdsDados := frmDigGiroEstoque.fraCalcGirFrame.cdsEmpSubtraiTansf;
        pTrataEmpresas('EMPTRA');
        pTrataMeses;
        pTrataNiveis;

        FreeAndNil(stlLista);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterfaceGiro.fAtualizaDadosGiro');
    End;
  End;
End;

Function TSalvaInterfaceGiro.fCarregaDados(strValKey: String; frmForm: TForm;
  strNomFrm: String = ''; strCodOpe: String = ''; blnRecuperandoPedido: Boolean = False; blnCarregaTela: Boolean = True): Boolean;
  Var
    stlLista: TStringList;
    cdsDados: TUniClientDataSet;
    intIndex: Integer;

    Procedure pTrataEmpresas(strCampo: String);
      Var
        strBusca,
        strEmpresas: String;
    Begin
      With frmDigGiroEstoque Do
      Begin
        If SameText(strCampo, 'MARDES') Then
          strBusca := cxGrid.Name
        Else
          strBusca := strCampo;

        If Locate('INT_NOMCOM', strBusca, []) Or
           (SameText(strCampo, 'EMPVIS') And Locate('INT_NOMCOM', cxGrid.Name, [])) Then
        Begin

          If SameText('EMPVIS', strCampo) And (Not blnEmpVis) Then
          Begin
            strEmpresas := '';
          End Else
          Begin
            strEmpresas := Trim(FieldByName('INT_VALCOM').AsString);
            strEmpresas := AnsiReplaceStr(strEmpresas, ' ', #13#10);
          End;

          stlLista.Text := strEmpresas;
          If Not SameText(strCampo, 'EMPTRA') Then
          Begin
            cdsDados := TUniClientDataSet(cxvEmpresas.DataController.DataSource.DataSet);

            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              cdsDados.Edit;

              If stlLista.Find(cdsDados.FieldByName('CODEMP').AsString, intIndex) Then
                cdsDados.FieldByName(strCampo).AsString := 'S'
              Else
                cdsDados.FieldByName(strCampo).AsString := 'N';

              cdsDados.Post;

              cdsDados.Next;
            End;
          End
          Else
          Begin
            strCampo := 'MARDES';
            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              cdsDados.Edit;

              If stlLista.Find(cdsDados.FieldByName('EMP_CODEMP').AsString, intIndex) Then
                cdsDados.FieldByName(strCampo).AsString := 'M'
              Else
                cdsDados.FieldByName(strCampo).AsString := 'D';

              cdsDados.Post;

              cdsDados.Next;
            End;

          End;

        End;

      End;
    End;

    Procedure pTrataMeses;
      Var
        intContador: Integer;
        strListaMeses: String;
    Begin
      With frmDigGiroEstoque, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        If chkInfMes.Checked And Locate('INT_NOMCOM', lblSelMes.Name, []) And
          Assigned(cdsMeses) And cdsMeses.Active Then
        Begin
          cdsMeses.blnTestaLimite := False;

          strListaMeses := Trim(FieldByName('INT_VALCOM').AsString);
          stlLista.Text := AnsiReplaceStr(strListaMeses, ' ', #13#10);

          cdsMeses.IndexFieldNames := 'ANOMES';

          For intContador := 0 To stlLista.Count - 1 Do
          If cdsMeses.Locate('ANOMES', stlLista[intContador], []) Then
          Begin
            cdsMeses.Edit;
            cdsMeses.FieldByName('SELECI').AsString := 'S';
            cdsMeses.Post;
          End;

          strMeses := cdsMeses.fRetMeses;

          cdsMeses.blnTestaLimite := True;
        End;

      End;
    End;

    Procedure pTrataNiveis;
      Var
        strNivel,
        strMarca,
        strQtdDia,
        strPerCon: String;
        intPos,
        intContador: Integer;
    Begin
      With frmDigGiroEstoque, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        cmbTipNivChange(Nil);

        cdsDados := TUniClientDataSet(cxvNivel.DataController.DataSource.DataSet);
        objNiveis.pTiraBeforePost;

        If Locate('INT_NOMCOM', cxgNivel.Name, []) Then
        Begin
          stlLista.Text := Trim(FieldByName('INT_VALCOM').AsString);

          For intContador := 0 To stlLista.Count - 1 Do
          Begin
            strPerCon := '';

            intPos   := Pos(';', stlLista[intContador]);

            strNivel := LeftStr(stlLista[intContador], Pred(intPos));

            If cdsDados.Locate('NIVGIR', strNivel, []) Then
            Begin
              strMarca := stlLista[intContador];
              System.Delete(strMarca, 1, intPos);
              intPos := Pos(';', strMarca);

              If Pos('/', strMarca) > 0 Then
              Begin
                strPerCon := RightStr(strMarca, Length(strMarca) - Pos('/', strMarca));
                System.Delete(strMarca, Pos('/', strMarca), Length(strMarca) - Pos('/', strMarca) + 1);
              End;

              strQtdDia := RightStr(strMarca, Length(strMarca) - intPos);
              strMarca  := LeftStr(strMarca, Pred(intPos));

              cdsDados.Edit;
              cdsDados.FieldByName('USANIV').AsString  := strMarca;
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(strQtdDia, 0);
              cdsDados.FieldByName('PERCON').AsFloat   := fStrToFloat(strPerCon);

              cdsDados.Post;
            End;

          End;

        End Else If Locate('INT_NOMCOM', 'chkUsaNivGir', []) And
                    (Trim(FieldByName('INT_VALCOM').AsString) = '1') Then // Compatibilidade com componentes excluidos
        Begin
          cmbTipNiv.ItemIndex := 1;
          cmbTipNivChange(Nil);

          If Locate('INT_NOMCOM', 'chkCalNivA', []) And
            (Trim(FieldByName('INT_VALCOM').AsString) = '1') And
            cdsDados.Locate('NIVGIR', 'A', []) Then
          begin
            cdsDados.Edit;
            cdsDados.FieldByName('USANIV').AsString  := 'S';

            If Locate('INT_NOMCOM', 'edtDiaComNivA', []) Then
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(Trim(FieldByName('INT_VALCOM').AsString), 0);

            cdsDados.Post;
           End;

          If Locate('INT_NOMCOM', 'chkCalNivB', []) And
            (Trim(FieldByName('INT_VALCOM').AsString) = '1') And
            cdsDados.Locate('NIVGIR', 'B', []) Then
          begin
            cdsDados.Edit;
            cdsDados.FieldByName('USANIV').AsString  := 'S';

            If Locate('INT_NOMCOM', 'edtDiaComNivB', []) Then
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(Trim(FieldByName('INT_VALCOM').AsString), 0);

            cdsDados.Post;
           End;

          If Locate('INT_NOMCOM', 'chkCalNivC', []) And
            (Trim(FieldByName('INT_VALCOM').AsString) = '1') And
            cdsDados.Locate('NIVGIR', 'C', []) Then
          begin
            cdsDados.Edit;
            cdsDados.FieldByName('USANIV').AsString  := 'S';

            If Locate('INT_NOMCOM', 'edtDiaComNivC', []) Then
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(Trim(FieldByName('INT_VALCOM').AsString), 0);

            cdsDados.Post;
           End;

        End;

        objNiveis.pPoeBeforePost;
      End;
    End;


Begin

  Try
    If (Not fEmptyStr(strCodOpe))
       And (Not SameText(strNomFrm, 'frmDigGiroEstoqueSpool'))
       And (Not SameText(strNomFrm, 'frmDigGiroEstoqueCotacao'))
       And (Not SameText(strNomFrm, 'frmGerarOrcamentoCompraAuto'))Then
      strNomFrm := 'frmDigGiroEstoque';

    pInicializaFrames;
    pSetFrame(frmDigGiroEstoque.fraCalcGirFrame);
    pSetFrame(frmDigGiroEstoque.fraCalcGirMesesFrame);

    Result := inherited fCarregaDados(strValKey, frmForm, strNomFrm, strCodOpe, blnCarregaTela);

    blnEncontrouGiro := Not Self.IsEmpty;

    If Result And blnCarregaTela And Assigned(frmDigGiroEstoque) Then
    With frmDigGiroEstoque, fraCalcGirFrame, fraCalcGirMesesFrame Do
    Begin
      stlLista := TStringList.Create;
      stlLista.Sorted := True;

      If blnEncontrouGiro Then
      begin
        strCodDigitador := '';
        if FEmptyStr(strComprador) then
        Begin
           //Verifica se é o código do operador que esta gravado.
          //Se estiver gravado código então carrega a senha
          If Not blnUsaDigitador Then
          Begin
            strComprador := fRetSenhaVendedor(frmDigGiroEstoque.edtCodCmp.Text);
            If Not fEmptyStr(strComprador) Then
              frmDigGiroEstoque.edtCodCmp.Text := strComprador
            Else
            Begin
             //  Se esta gravado senha, verfica se a senha carregada no campo é valida.
             //caso não for limpa o campo
             strComprador := fRetCodVendedor(frmDigGiroEstoque.edtCodCmp.Text);
             If fEmptyStr(strComprador) then
               frmDigGiroEstoque.edtCodCmp.Text := '';
            End;
          End
          Else
          Begin
            //Verifica se esta garavado a senha
            strComprador := fRetCodVendedor(frmDigGiroEstoque.edtCodCmp.Text);
            //Se  estiver gravado a senha então carrega o Codigo do Operador
            //Caso contrario o código ja estara correto pois esta gravado o Código do Operador;
            If Not fEmptyStr(strComprador) Then
              frmDigGiroEstoque.edtCodCmp.Text := strComprador;

            //Campo do Digitador
            //Verifica se é o código do operador que esta gravado.
            strCodDigitador := fRetSenhaVendedor(frmDigGiroEstoque.edtCodDig.Text);
           //Se estiver gravado código então carrega a senha
            If Not fEmptyStr(strCodDigitador) Then
              frmDigGiroEstoque.edtCodDig.Text := strCodDigitador
            Else
            Begin
             //  Se esta gravado senha, verfica se a senha carregada no campo é valida.
             //caso não for limpa o campo
             strCodDigitador := fRetCodVendedor(frmDigGiroEstoque.edtCodDig.Text);
             If fEmptyStr(strCodDigitador) then
               frmDigGiroEstoque.edtCodDig.Text := '';
            End;
          End;
        End;
      End;

      // PARA NÃO EXLCLUIR DO GIRO ITENS QUE ESTÃO NO PEDIDO
      If blnExibiItens And (Not blnRecuperandoPedido) Then
        chkExibItens.Checked := True;

      pTrataEmpresas('MARDES');
      pTrataEmpresas('EMPVIS');

      cdsDados := frmDigGiroEstoque.fraCalcGirFrame.cdsEmpSubtraiTansf;
      pTrataEmpresas('EMPTRA');


      pTrataMeses;
      pTrataNiveis;

      FreeAndNil(stlLista);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterfaceGiro.fCarregaDados');
    End;
  End;

End;

Procedure TSalvaInterfaceGiro.pSetaFiltro(strNomeFiltro, strValor: String);
Begin
  pLocalizaRegistro(strNomeFiltro);

  FieldByName('INT_VALCOM').AsString := strValor;
End;

Function TSalvaInterfaceGiro.fSalvaDados(strValKey: String;
                                         strNomFrm: String = '';
                                         strCodOpe: String = '';
                                         blnAtualizaDados: Boolean = False;
                                         arrCampos: TArrString = Nil;
                                         strNomeTabela: String = 'CADINT'): Boolean;
begin
  If IsEmpty And (Not blnAtualizaDados) Then
  Begin
    Result := True;
    Exit;
  End;

  strNomTab := strNomeTabela;

  if fEmptyStr(strCodVendedor) then
  Begin
    pLocalizaRegistro('edtCodCmp');
    strCodVendedor := fRetCodVendedor(FieldByName('INT_VALCOM').AsString);
    If Not fEmptyStr(strCodVendedor) Then
      FieldByName('INT_VALCOM').AsString := strCodVendedor
    Else
      strCodVendedor := FieldByName('INT_VALCOM').AsString;

    If blnUsaDigitador Then
    Begin
      pLocalizaRegistro('edtCodDig');
      strCodDigitador := fRetCodVendedor(FieldByName('INT_VALCOM').AsString);
      If Not fEmptyStr(strCodDigitador) Then
        FieldByName('INT_VALCOM').AsString := strCodVendedor
    End;

   Post;

  End;

  Result := inherited fSalvaDados(strValKey, strNomFrm, strCodOpe, blnAtualizaDados, Nil, strNomeTabela);
end;

Function TSalvaInterfaceGiro.fSalvaDadosDesmembrado(strValKey, strNomFrm, strCodEmp: String; strCodOpe: String = ''): Boolean;
Begin
  If Self.Active Then
  Begin
    pLocalizaRegistro('cxGrid');
    FieldByName('INT_VALCOM').AsString := Trim(strCodEmp);
    Post;

    pLocalizaRegistro('EMPVIS');
    FieldByName('INT_VALCOM').AsString := Trim(strCodEmp);
    Post;

    pLocalizaRegistro('chkAgrEmp');
    FieldByName('INT_VALCOM').AsString := 'N';

    //Verifica se o valor informado é senha, caso for carrega o codigo do operado.
    //Sempre deve salvar .
    Post;
  End;

  Result := fSalvaDados(strValKey, strNomFrm, strCodOpe) And
            fSalvaDados(strValKey, strNomFrm, strCodOpe, False, Nil, 'CADINTTUD');
End;

Class Function TSalvaInterfaceGiro.fApagaInterfacePedido(strValKey: String; strCodOpe: String = ''): Boolean;
Begin
  Result := fApagaInterface(strValKey, 'frmDigGiroEstoque', strCodOpe, 'CADINT');
End;

Class Function TSalvaInterfaceGiro.fApagaInterfaceCotacao(strValKey: String; strCodOpe: String = ''): Boolean;
Begin
  Result := fApagaInterface(strValKey, 'frmDigGiroEstoqueCotacao', strCodOpe, 'CADINT');
End;


end.
