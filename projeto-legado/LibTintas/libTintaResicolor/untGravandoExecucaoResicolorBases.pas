{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Resicolor *}
{*******************************************************************************AC*}
unit untGravandoExecucaoResicolorBases;

interface

uses
  untAbstractGravandoExecucaoResicolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils, DB, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TGravandoExecucaoResicolorBases = class(TAbstractGravandoExecucaoResicolor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

Uses
  untStrUtils;

{ TGravandoExecucaoResicolorBases }

procedure TGravandoExecucaoResicolorBases.Executar(const gravando: IGravando);
Var
  intProducts : Integer;
  intSubProds : Integer;
  intFrm      : Integer;
  intMask     : Integer;
  intPos      : Integer;

  strProKey   : String;
  strPatPro   : String;
  strPatSub   : String;
  strSubKey   : String;
  strBaseSe   : String;
  strEmbCom   : String;
  strFormula  : String;
  strSQLBase  : String;

  arrColRsi   : Array Of TColRsi;
  strQtdEmb   : String;
  strDesTin   : String;
  intColora   : Integer;
  intQtdRegFrm: Integer;
Const
    MAX_QTD_REG_FRM = 1200;
begin
  Try
    Try
      Gravando.Texto := 'Verificando path do arquivo...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Path verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Bases e Colorantes...';

      blnQtdRgt := True;
      pCarregarProdutos;
      pCarregarBases;

      strSQLBase := tblBases.SQL.Text;

      Gravando.Texto := 'Verificando Cadastro de Embalagens...';

      If Not fVerificaCadastroEmbalagem() Then
      Begin
        If qryRSI_CADEMB.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
          Begin
            Try
              pImportarCadastroEmbalagem(Gravando);
              Gravando.Texto := 'Cadastro de Embalagens processado com sucesso...';
              Gravando.RegistrarProgresso(0, 0, 0);
            Except
              On E: Exception Do
              Begin
                Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
                Exit;
              End;
            End;
          End;
        End
        Else
        Begin
          Gravando.Texto := 'O cadastro de Embalagem está inconsistente!';
          Gravando.Texto := 'Para você continuar, deve importar o cadastro de embalagem...';
        End;

        Exit;
      End;

      Gravando.Texto := 'Cadastro de Embalagem verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('RSI_CADBAS');
      TAutcomTintaFactory.Get.fInsereProCod('RSI_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Processando Cadastro de Bases e Colorantes...';


      For intProducts := 1 To tblProducts.RecordCount Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strPatPro := GetPath + '\' + tblProducts.FieldByName('PATH').AsString;
        strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);

        Gravando.Texto := Format('Processando Produto: [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);

        pCarregarSubProdutos(strPatPro);

        For intSubProds := 1 To tblSubProds.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatSub := strPatPro + '\' + tblSubProds.FieldByName('PATH').AsString;
          strSubKey := TStrUtils.fStrZero(Trim(tblSubProds.FieldByName('ID').AsString), 2);

          pCarregarFrm(strPatPro, strPatSub, Gravando);

          Gravando.Texto := Format('Processando Subproduto: [%s]' , [AnsiReplaceStr(strPatSub, '"', '')]);

          pCarregarMask(strPatSub);
          pCarregarRuler(strPatSub);

          intQtdRegFrm := qryFrm.RecordCount;

          For intFrm := 1 To intQtdRegFrm Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            strBaseSe := TStrUtils.fStrZero(Trim(qryFrm.FieldByName('BASE_ID').AsString), 2);

            If strBaseSe = '00' Then
              Continue;

            strEmbCom := TStrUtils.fStrZero(Trim(qryFrm.FieldByName('CAN_ID').AsString), 2);

            tblRuler.Locate('ID', qryFrm.FieldByName('BASE_ID').AsString, []);

            qryRSI_CADEMB.First;

            For intMask := 1 To qryRSI_CADEMB.RecordCount Do
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;

              strFormula := qryFrm.FieldByName('FORMULA').AsString;
              SetLength(arrColRsi, 0);

              While Not TStrUtils.fEmptyStr(strFormula) Do
              Begin
                SetLength(arrColRsi, Length(arrColRsi) + 1);
                intPos := Pos(',', strFormula);

                arrColRsi[Length(arrColRsi) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);

                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                intPos := Pos(',', strFormula);

                If intPos <= 0 Then
                  intPos := Length(strFormula)+1;

                arrColRsi[Length(arrColRsi) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ',')) * 0.616125
                                                              * TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Trim(tblRuler.FieldByName('RULE').AsString),'.',','));

                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              End;

              SetLength(arrColRsi, 20);
              strQtdEmb := TStrUtils.fStrZero(Trim(qryRSI_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

              If (qryRSI_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
              Begin
                tblBases.First;
                While Not tblBases.Eof Do
                Begin

                  If Trim(tblBases.FieldByName('ID').AsString) <> Trim(qryFrm.FieldByName('BASE_ID').AsString) Then
                  Begin
                    tblBases.Next;
                    Continue;
                  End;

                  If Trim(tblBases.FieldByName('PROD_KEY').AsString) <> Trim(tblProducts.FieldByName('ID').AsString) Then
                  Begin
                    tblBases.Next;
                    Continue;
                  End;

                  If Trim(tblBases.FieldByName('SUBP_KEY').AsString) <> Trim(tblSubProds.FieldByName('ID').AsString) Then
                  Begin
                    tblBases.Next;
                    Continue;
                  End;




                {tblBases.Close;
                tblBases.SQL.Clear;


                  tblBases.SQL.Text := strSQLBase + ' WHERE TRIM(ID) = :BASE_ID        '+
                                                    '   AND TRIM(PROD_KEY) = :PROD_KEY '+
                                                    '   AND TRIM(SUBP_KEY) = :SUBP_KEY ';
                tblBases.ParamByName('BASE_ID').AsString  := Trim(tblFrm.FieldByName('BASE_ID').AsString);
                tblBases.ParamByName('PROD_KEY').AsString := Trim(tblProducts.FieldByName('ID').AsString);
                tblBases.ParamByName('SUBP_KEY').AsString := Trim(tblSubprods.FieldByName('ID').AsString);
                tblBases.Open; }
                  Begin

                    If (Gravando.Status <> sgGravando) Then
                      Break;

                    qryRSI_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                    strDesTin := AnsiUpperCase(Trim(tblSubProds.FieldByName('DESCR').AsString) + ' ' +
                      Trim(tblBases.FieldByName('DESCR').AsString) + ' ' + FormatFloat('0.00', qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

                    pGravaCadastroColorantes(arrColRsi, Gravando);
                    pGravarCadastroBases(strBaseSe, strProKey, strSubKey, strDesTin, Gravando);
                  End;

                  tblBases.Next;
                End;

              End;

              qryRSI_CADEMB.Next;
            End;

            qryFrm.Next;
            Gravando.RegistrarProgresso(0, qryFrm.RecNo, intQtdRegFrm);
          End;

          tblSubProds.Next;
          Gravando.RegistrarProgresso(0, tblSubProds.RecNo, tblSubProds.RecordCount);
        End;

        tblProducts.Next;
        Gravando.RegistrarProgresso(0 , tblProducts.RecNo, tblProducts.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Bases e Colorantes processado com sucesso...';
  End;
end;

function TGravandoExecucaoResicolorBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases e Colorantes';
end;


end.

