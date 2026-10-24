{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta AnjoSintetica *}
{**********************************************************************PH*}
unit untGravandoExecucaoAnjoSinteticaCores;

interface

uses
  untAbstractGravandoExecucaoAnjoSintetica, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB;

type
  TGravandoExecucaoAnjoSinteticaCores = class(TAbstractGravandoExecucaoAnjoSintetica)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoAnjoSinteticaCores }

procedure TGravandoExecucaoAnjoSinteticaCores.Executar(const gravando: IGravando);
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

  arrColAja   : Array Of TColAja;
  strQtdEmb   : String;
  strDesTin   : String;
  intColora   : Integer;
  intCodSeq   : Integer;
begin
  Gravando.Texto := 'Verificando diretorio do arquivo...';

  If Not fValidaDiretorio Then
  Begin
    Gravando.Texto := Format('O diretorio % configurado não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Diretorio do arquivo verificado...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Tintas...';

  qryAJA_CADAJA.Close;
  qryAJA_CADAJA.SQL := ' DELETE FROM AJA_CADAJA ';
  qryAJA_CADAJA.ExecSQL;

  qryAJA_CADAJA.SQL := ' SELECT * FROM AJA_CADAJA WHERE FALSE ';
  qryAJA_CADAJA.Open;

  pCarregarProdutos;
  pCarregarBases;
  intCodSeq := 1;
  pAtualizarTabelas;

  Gravando.Texto := 'Verificando Cadastro de Embalagem...';

  If Not fVerificaCadEmb Then
  Begin
    If qryAJA_CADEMB.IsEmpty Then
    Begin
      If TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?',
        ['&Sim', '&Não']) = 1 Then
      Begin
        pGravaCadEmb(Gravando);
        Gravando.RegistrarProgresso(0, 0, 0);
      End
      Else
      Begin
        Gravando.Texto := 'O Cadastro de Embalagem está vazio!';
        Exit;
      End;
    End
    Else
    Begin
      Gravando.Texto := 'O Cadastro de Embalagem está inconsistente!';
      Exit;
    End;
  End;

  Gravando.Texto := 'Cadastro de Embalagem verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  If Not fVerificaCadBas Then
  Begin
    Gravando.Texto := 'O Cadastro de Bases está vazio!';
    Exit;
  End;

  If Not fVerificaCadCol Then
  Begin
    Gravando.Texto := 'O Cadastro de Colorantes está vazio!';
    Exit;
  End;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('AJA_CADAJA');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := Format('Processando Arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  For intProducts := 1 To tblProducts.RecordCount Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    strPatPro := GetPath + '\' + tblProducts.FieldByName('PATH').AsString + '\';
    strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);

    Gravando.Texto := Format('Carregando Produto... [%s]', [AnsiReplaceStr(strPatPro, '"', '')]);

    pCarregarSubProduto(strPatPro, Gravando);

    For intSubProds := 1 To tblSubProds.RecordCount Do
    Begin

      If (Gravando.Status <> sgGravando) Then
        Break;

      strPatSub := strPatPro + '\' + tblSubProds.FieldByName('PATH').AsString + '\';
      strSubKey := TStrUtils.fStrZero(Trim(tblSubProds.FieldByName('ID').AsString), 2);

      pCarregarFrm(strPatPro, strPatSub, Gravando);
      pCarregarMask(strPatSub, Gravando);

      Gravando.Texto := Format('Processando Subproduto... [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);

      For intFrm := 1 To tblFrm.RecordCount Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strBaseSe := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('BASE_ID').AsString), 2);
        strEmbCom := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

        qryAJA_CADEMB.First;

        For intMask := 1 To qryAJA_CADEMB.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColAja, 0);

          While Not TStrUtils.fEmptyStr(strFormula) Do
          Begin
            SetLength(arrColAja, Length(arrColAja) + 1);
            intPos := Pos(',', strFormula);
            arrColAja[Length(arrColAja) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);

            If intPos <= 0 Then
              intPos := Length(strFormula)+1;

            arrColAja[Length(arrColAja) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColAja, 20);
          strQtdEmb := TStrUtils.fStrZero(Trim(qryAJA_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

          If (qryAJA_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
          Begin
            tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
            qryAJA_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

            strDesTin := AnsiUpperCase(
              tblFrm.FieldByName('KEY1').AsString + ' ' +
              Trim(tblSubProds.FieldByName('DESCR').AsString) + ' ' +
              tblFrm.FieldByName('KEY2').AsString
              );

            For intColora := Low(arrColAja) To High(arrColAja) Do
            Begin

              If TStrUtils.fEmptyStr(arrColAja[intColora].strCodCol) Then
                Break;

              arrColAja[intColora].fltQtdCol := fCalQtdEmb(strEmbCom, strQtdEmb, arrColAja[intColora].fltQtdCol);
            End;

            If fGravaCadAja(intCodSeq, strBaseSe, strProKey, strSubKey, strDesTin, arrColAja, Gravando) Then
              Inc(intCodSeq);
          End;
          qryAJA_CADEMB.Next;
        End;
        tblFrm.Next;
        Gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);
      End;
      tblSubProds.Next;
      Gravando.RegistrarProgresso(0, tblSubProds.RecNo, tblSubProds.RecordCount);
    End;
    tblProducts.Next;
    Gravando.RegistrarProgresso(0, tblProducts.RecNo, tblProducts.RecordCount);
  End;
end;


function TGravandoExecucaoAnjoSinteticaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Tintas';
end;

end.
