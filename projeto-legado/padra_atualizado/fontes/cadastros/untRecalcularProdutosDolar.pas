unit untRecalcularProdutosDolar;

interface

Uses
  Uni, SysUtils, ComCtrls, Forms, cxProgressBar,
  untParCalculaPrecoCusto, untFatorPreco;

Type
  TRecalcularProdutosDolar = Class(TObject)

  Private
    qryCons   : TUniQuery;
    objFatPre : TFatorPreco;
    FFatPre   : Boolean;
    FPreVen   : Double;

    function fRetPrecoCusto(Const blnUtilizarConversorDeMoeda: Boolean): Double;
    function fRetPrecoVenda(intOpcao, intNumPreVen: Integer; fltPreCus: Double): Double;
    function fRetornaSQLProdutosDolar: String;

    Function fRecalcularOsProdutosPrg(cxProgresso: TcxProgressBar): Boolean;

  Public
    Constructor Create; Reintroduce;

    procedure pRecalcularOsProdutos;    
  End;


implementation

uses untFuncoesSimples, untTConfiguracao, Data.DB, untGravando;

{ TRecalcularProdutosDolar }

constructor TRecalcularProdutosDolar.Create;
begin
  Inherited;
  qryCons := fCriaQuery(Nil);
  FFatPre := fCfgSis('FATPRE', varBoolean);
  FPreVen := 0;
end;

function TRecalcularProdutosDolar.fRetornaSQLProdutosDolar: String;
begin
  Result := '';
  Result := Result + ' SELECT ITE_PRECOM, ';
  Result := Result + '        ITE_DESF01, ';
  Result := Result + '        ITE_DESF02, ';
  Result := Result + '        ITE_DESF03, ';
  Result := Result + '        ITE_DESF04, ';
  Result := Result + '        ITE_DESF05, ';
  Result := Result + '        ITE_DESF06, ';
  Result := Result + '        ITE_ICMENT, ';
  Result := Result + '        ITE_IPIENT, ';
  Result := Result + '        ITE_FREENT, ';
  Result := Result + '        ITE_ACRFIN, ';
  Result := Result + '        ITE_SUBSTI, ';
  Result := Result + '        ITE_VALFRE, ';
  Result := Result + '        ITE_DESADB, ';
  Result := Result + '        ITE_SUBFED, ';
  Result := Result + '        ITE_CODITE, ';
  Result := Result + '        ITE_CODEMP, ';
  Result := Result + '        ITE_OUTVAL, ';
  Result := Result + '        ITE_MARBR1, ';
  Result := Result + '        ITE_MARBR2, ';
  Result := Result + '        ITE_MARBR3, ';
  Result := Result + '        ITE_MARBR4, ';
  Result := Result + '        ITE_MARBR5, ';
  Result := Result + '        ITE_MARBR6, ';
  Result := Result + '        ITE_MARBR7, ';
  Result := Result + '        ITE_ICMSAI, ';
  Result := Result + '        ITE_IMPFED, ';
  Result := Result + '        ITE_DESOPE, ';
  Result := Result + '        ITE_COMTB1, ';
  Result := Result + '        ITE_COMTB2, ';
  Result := Result + '        ITE_COMTB3, ';
  Result := Result + '        ITE_COMTB4, ';
  Result := Result + '        ITE_COMTB5, ';
  Result := Result + '        ITE_COMTB6, ';
  Result := Result + '        ITE_COMTB7, ';
  Result := Result + '        ITE_PREVE1, ';
  Result := Result + '        ITE_PREVE2, ';
  Result := Result + '        ITE_PREVE3, ';
  Result := Result + '        ITE_PREVE4, ';
  Result := Result + '        ITE_PREVE5, ';
  Result := Result + '        ITE_PREVE6, ';
  Result := Result + '        ITE_PREVE7, ';
  Result := Result + '        ITE_TCIFCU, ';
  Result := Result + '        ITE_TSCUST, ';
  Result := Result + '        ITE_DEPICO, ';
  Result := Result + '        ITE_DEICMS, ';
  Result := Result + '        ITE_FATREG  ';
  Result := Result + '   FROM ITEGER      ';
  Result := Result + '  WHERE ITE_PREDOL = "S" ';
//  Result := Result + '    AND ITE_CODEMP = :CODEMP ';
end;

function TRecalcularProdutosDolar.fRetPrecoCusto(Const blnUtilizarConversorDeMoeda: Boolean): Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
begin
  Try

    cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      curPreCom := qryCons.FieldByName('ITE_PRECOM').AsFloat;
      curDesF01 := qryCons.FieldByName('ITE_DESF01').AsFloat;
      curDesF02 := qryCons.FieldByName('ITE_DESF02').AsFloat;
      curDesF03 := qryCons.FieldByName('ITE_DESF03').AsFloat;
      curDesF04 := qryCons.FieldByName('ITE_DESF04').AsFloat;
      curDesF05 := qryCons.FieldByName('ITE_DESF05').AsFloat;
      curDesF06 := qryCons.FieldByName('ITE_DESF06').AsFloat;
      curICMSEnt:= qryCons.FieldByName('ITE_ICMENT').AsFloat;
      curIPIEnt := qryCons.FieldByName('ITE_IPIENT').AsFloat;
      curFrete  := qryCons.FieldByName('ITE_FREENT').AsFloat;
      curAcrFin := qryCons.FieldByName('ITE_ACRFIN').AsFloat;
      curSubsti := qryCons.FieldByName('ITE_SUBSTI').AsFloat;
      curValFre := qryCons.FieldByName('ITE_VALFRE').AsFloat;
      curDesAdb := qryCons.FieldByName('ITE_DESADB').AsFloat;
      curSubFed := qryCons.FieldByName('ITE_SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := qryCons.FieldByName('ITE_TCIFCU').AsFloat;
        curTSCust := qryCons.FieldByName('ITE_TSCUST').AsFloat;
        curDePiCo := qryCons.FieldByName('ITE_DEPICO').AsFloat;
        curDeICMS := qryCons.FieldByName('ITE_DEICMS').AsFloat;
        curFatReg := qryCons.FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;
    Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);

  Finally
    FreeAndNil(cpcParams);
  End;
end;

function TRecalcularProdutosDolar.fRetPrecoVenda(intOpcao,
  intNumPreVen: Integer; fltPreCus: Double): Double;
begin
  If intNumPreVen In [1..Length(VS_strTabPrc)] Then
  Begin
    If (intOpcao = 2 {Margem}) Or (Not FFatPre) Or (intNumPreVen = 1) Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPrecus + qryCons.FieldByName('ITE_OUTVAL').AsFloat,
                                   qryCons.FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat,
                                   qryCons.FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat,
                                   qryCons.FieldByName('ITE_ICMSAI').AsFloat,
                                   qryCons.FieldByName('ITE_IMPFED').AsFloat,
                                   qryCons.FieldByName('ITE_DESOPE').AsFloat,
                                   qryCons.FieldByName('ITE_COMTB' + IntToStr(intNumPreVen)).AsFloat)

    Else If intOpcao = 1 Then
      Result := qryCons.FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat

    Else Result := qryCons.FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat;

  End
  Else
  Begin
    Result := -1;
    fMensagem('', 'fRetPrecoVenda: Escolha a Opção 1 a 7!', ['&Ok']);
  End;
end;

procedure TRecalcularProdutosDolar.pRecalcularOsProdutos;
  Var
    frmGravando: TFrmGravando;
Begin
  TFrmGravando.fExecuta(fRecalcularOsProdutosPrg, frmGravando, 'Recalculando preços, aguarde...');
End;

Function TRecalcularProdutosDolar.fRecalcularOsProdutosPrg(cxProgresso: TcxProgressBar): Boolean;
  var
    qryUpd     : TUniQuery;
    fltPreCus  : Double;
    intTabPre  : Integer;
    intContador: Integer;
begin
  Try
    VS_blnGravaLogTransacao := False;
    VS_GravaUsuRep := 'N';

    Result := True;

    Try
      If FFatPre Then
        objFatPre := TFatorPreco.Create;
      qryUpd  := fCriaQuery(Nil);

      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLProdutosDolar);
     //   ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        cxProgresso.Properties.Max := qryCons.RecordCount;

        If Not IsEmpty Then
        Begin
          First;
          While Not Eof Do
          Begin
            fltPreCus := fRetPrecoCusto(true);

            qryUpd.Close;
            qryUpd.SQL.Clear;
            qryUpd.SQL.Add(' UPDATE ITEGER ');
            qryUpd.SQL.Add('    SET ITE_PRECUS = :PRECUS ');


            For intTabPre := 1 To Length(VS_strTabPrc) Do
            Begin
              qryUpd.SQL.Add(' ,ITE_PREVE' + IntToStr(intTabPre) + ' = :PREVE' + IntToStr(intTabPre));
            End;

//            pRecalculaPrecosFator
            If FFatPre Then
            Begin
              For intContador := 2 To 7 Do
              Begin
                qryUpd.SQL.Add(' ,ITE_MARBR' + IntToStr(intContador) + ' = :MARBR' + IntToStr(intContador));
              End;
            End;

            qryUpd.SQL.Add('  WHERE ITE_CODITE = :CODITE ');
            qryUpd.SQL.Add('    AND ITE_CODEMP = :CODEMP ');

            qryUpd.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
            qryUpd.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
            qryUpd.ParamByName('PRECUS').AsFloat  := fltPreCus;

            For intTabPre := 1 To Length(VS_strTabPrc) Do
            Begin
              qryUpd.ParamByName('PREVE' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(1, intTabPre, fltPreCus);

              If intTabPre = 1 Then
                FPreVen := qryUpd.ParamByName('PREVE' + IntToStr(intTabPre)).AsFloat;
            End;

//            pRecalculaPrecosFator
            If FFatPre Then
            Begin
              For intContador := 2 To 7 Do
              Begin
                If objFatPre.fTabelaAtiva(intContador) Then
                begin
                  qryUpd.ParamByName('PREVE' + IntToStr(intContador)).AsFloat :=
                  objFatPre.fCalculaPrecoVendaFator(FPreVen, intContador);

                  qryUpd.ParamByName('MARBR' + IntToStr(intContador)).AsFloat :=
                  fCalculaPrecoVenda(2,
                                     fltPreCus + FieldByName('ITE_OUTVAL').AsFloat,
                                     FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                                     0,
                                     FieldByName('ITE_ICMSAI').AsFloat, FieldByName('ITE_IMPFED').AsFloat,
                                     FieldByName('ITE_DESOPE').AsFloat, FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat);

                End;
              End;
            End;

            fStartTransaction;
            qryUpd.ExecSQL;
            fCommit;

            If qryCons.RecNo Mod 100 = 0 Then
            Begin
              cxProgresso.Position := qryCons.RecNo;
              Application.ProcessMessages;
            End;

            Next;
          End;
    //      fMensagem('INFORMAÇÃO','Produtos atualizados como sucesso !',['&Ok']);
        End;
      End;

    Except
      on E: Exception do
      begin
        Result := False;

        fRollBack;
        pMensagensErro(E.Message, '[fUltimaCotaocaoDolar]');
      end;
    End;
  Finally
    VS_blnGravaLogTransacao := True;
    VS_GravaUsuRep := 'S';

    If Assigned(objFatPre) then
      objFatPre.Free;
    FreeAndNil(qryCons);
    FreeAndNil(qryUpd);
  End;
end;

end.
