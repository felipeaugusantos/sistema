{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Weg *}
{*******************************************************************************AC*}
unit untGravandoExecucaoWegBases;

interface

uses
  untAbstractGravandoExecucaoWeg, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils, untStrUtils;

type
  TGravandoExecucaoWegBases = class(TAbstractGravandoExecucaoWeg)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoWegBases }

procedure TGravandoExecucaoWegBases.Executar(const gravando: IGravando);
Var
  intProducts: Integer;
  intSubProds: Integer;
  intFrm: Integer;
  intMask: Integer;
  intPos: Integer;

  strProKey:String;
  strPatPro:String;
  strSubKey:String;
  strPatSub:String;
  strBase:String;
  strFormula:String;
  strQtdEmb:String;
  strDescri:String;


  arrColWeg: Array of TColWeg;
begin
  Gravando.Texto := 'Verificando diretorio configurado...';

  If Not fValidaDiretorio Then
  Begin
    Gravando.Texto := Format('O path %s configurado não é valido!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Diretorio verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Bases e Colorantes...';

  pCarregarProdutos(Gravando);
  pCarregarBases(Gravando);
  pCarregarCnts(Gravando);
  pAtualizarTabela;

  Gravando.Texto := 'Verificando Cadastro de Embalagem...';

  If Not fValidaCadEmbalagem() Then
  Begin
    If qryWEG_CADEMB.IsEmpty Then
    Begin
      If TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?',
        ['&Sim', '&Não']) = 1 Then
        fGravarCadEmb(Gravando)
      Else
        Exit;
    End
    Else
    Begin
      TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de embalagem está inconsistente!' + #13#10 +
        'Para continuar você deve importa-lo.', ['&OK']);
      Exit;
    End;
  End;

  Gravando.Texto := 'Cadastro de Embalagem verificado com sucesso...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('WEG_CADBAS');
  TAutcomTintaFactory.Get.fInsereProCod('WEG_CADCOL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := Format('Abrindo Arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);

  Try
    Try
      For intProducts := 1 To tblProdutos.RecordCount Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strPatPro := GetPath + '\' + tblProdutos.FieldByName('PATH').AsString;
        strProKey := TStrUtils.fStrZero(Trim(tblProdutos.FieldByName('ID').AsString), 2);
        pCarregarSubProdutos(strPatPro, Gravando);

        Gravando.Texto := Format('Carregando Produto: [%s]', [AnsiReplaceStr(strPatPro,'"', '')]);

        For intSubProds := 1 To tblSubprods.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString;
          strSubKey := TStrUtils.fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
          pCarregarFrm(strPatPro, strPatSub, Gravando);
          pCarregarMask(strPatSub, Gravando);
          Gravando.Texto := Format('Processando Subproduto: [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);

          For intFrm := 1 To tblFrm.RecordCount Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            strBase := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('BASE_ID').AsString), 2);

            qryWEG_CADEMB.First;

            For intMask := 1 To qryWEG_CADEMB.RecordCount Do
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;

              strFormula := tblFrm.FieldByName('FORMULA').AsString;
              SetLength(arrColWeg, 0);

              While Not (TStrUtils.fEmptyStr(strFormula)) Do
              Begin
                SetLength(arrColWeg, Length(arrColWeg) + 1);
                intPos := Pos(',', strFormula);
                arrColWeg[Length(arrColWeg) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                intPos := Pos(',', strFormula);

                If intPos <= 0 Then
                  intPos := Length(strFormula) + 1;

                arrColWeg[Length(arrColWeg) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              End;

              SetLength(arrColWeg, 20);
              strQtdEmb := TStrUtils.fStrZero(Trim(qryWEG_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

              If (qryWEG_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
              Begin
                tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
                qryWEG_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                strDescri := AnsiUpperCase(Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                FormatFloat('0.00', qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

                fGravarCadCol(ArrColWeg, Gravando);
                fGravarCadBas(strBase, strProKey, strSubKey, strDescri, Gravando);
              End;

              qryWEG_CADEMB.Next;
            End;

            tblFrm.Next;
            Gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);
          End;

          tblSubprods.Next;
          Gravando.RegistrarProgresso(0, tblSubProds.RecNo, tblSubprods.RecordCount);
        End;

        tblProdutos.Next;
        Gravando.RegistrarProgresso(0, tblProdutos.RecNo, tblProdutos.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := Format('Cadastro de %s e %s processado com sucesso!', ['Bases', 'Colorantes']);
  End;




end;

function TGravandoExecucaoWegBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases/Colorantes';
end;


end.
