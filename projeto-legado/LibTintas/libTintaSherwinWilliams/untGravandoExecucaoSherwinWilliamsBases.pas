{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta SherwinWilliams *}
{*******************************************************************************AC*}
unit untGravandoExecucaoSherwinWilliamsBases;

interface

uses
  untAbstractGravandoExecucaoSherwinWilliams, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils, untStrUtils;

type
  TGravandoExecucaoSherwinWilliamsBases = class(TAbstractGravandoExecucaoSherwinWilliams)
  private
    procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoSherwinWilliamsBases }

procedure TGravandoExecucaoSherwinWilliamsBases.Executar(const gravando: IGravando);
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

    arrColShe   : Array Of TColShe;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;

    strPatDbf   : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      If Not fVerificaCadEmb Then
      Begin
        If qrySHE_CADEMB.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
            pImportarCadEmb(gravando);
        End
        Else
          gravando.Texto := 'O Cadastro de Embalagem está inconsistente!';

        gravando.Cancelar;
        Exit;
      End;

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHE_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando a Geração do Cadastro de Bases ...';

      strPatDbf := GetPath;

      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          For intProducts := 1 To tblProducts.RecordCount Do
          Begin
            strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString;
            strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);
            pCarregarSubprods(strPatPro);

            if gravando.Status <> sgGravando then
              Exit;

            If tblSubprods.Active Then
            Begin
              For intSubProds := 1 To tblSubprods.RecordCount Do
              Begin
                strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString;
                strSubKey := TStrUtils.fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
                pCarregarFrm(strPatPro, strPatSub, gravando);
                pCarregarMask(strPatSub);

                if gravando.Status <> sgGravando then
                  Exit;

                For intFrm := 1 To tblFrm.RecordCount Do
                Begin
                  strBaseSe := TStrUtils.fStrZero(Trim(tblFrm.FieldbyName('BASE_ID').AsString), 2);
                  strEmbCom := TStrUtils.fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

                  tblMask.First;

                  For intMask := 1 To tblMask.RecordCount Do
                  Begin
                    strFormula := tblFrm.FieldByName('FORMULA').AsString;
                    SetLength(arrColShe, 0);

                    While (Not TStrUtils.fEmptyStr(strFormula)) Do
                    Begin
                      SetLength(arrColShe, Length(arrColShe) + 1);
                      intPos := Pos(',', strFormula);
                      arrColShe[Length(arrColShe) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                      strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                      intPos := Pos(',', strFormula);
                      If intPos <= 0 Then
                        intPos := Length(strFormula)+1;
                      arrColShe[Length(arrColShe) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));

                      {*******************************************}
                      {* FORMULA GEL TEM QUE MULTIPLICAR POR 0.2 *}
                      {****************************************PH*}
                      If (tblProducts.FieldByName('PATH').AsString = 'PROD0005')
                        And (tblSubprods.FieldByName('PATH').AsString = 'SUBP0001') Then
                      Begin
                        arrColShe[Length(arrColShe) - 1].fltQtdCol := arrColShe[Length(arrColShe) - 1].fltQtdCol * 0.2;
                      End;

                      strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                    End;

                    SetLength(arrColShe, 20);
                    strQtdEmb := TStrUtils.fStrZero(Trim(tblMask.FieldByName('PNT_ID').AsString), 2);

                    If (tblMask.FieldByName('TYPE').AsString = 'CA') Then
                    Begin
//                      tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
                      pLocalizaBase(tblFrm.FieldByName('BASE_ID').AsString);
                      qrySHE_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

                      strDesTin := AnsiUpperCase(
                                 Trim(tblProducts.FieldByName('DESCR').AsString) + ' ' +
                                 Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                                 Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                                 FormatFloat('0.00', qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

                      pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin);
                    End;
                    tblMask.Next;
                  End;
                  gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);

                  tblFrm.Next;
                End;
                tblSubprods.Next;
              End;
            End;
            tblProducts.Next;
          End;
        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;
        End;
      Finally
        gravando.Texto := 'Finalizado o processo de gravação do arquivo...';
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoSherwinWilliamsBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TGravandoExecucaoSherwinWilliamsBases.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
begin
  If Not qrySHE_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qrySHE_CADBAS.Insert;
    qrySHE_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qrySHE_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qrySHE_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qrySHE_CADBAS.FieldByName('BAS_UNIDAD').AsString := qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qrySHE_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qrySHE_CADBAS.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qrySHE_CADBAS.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHE_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qrySHE_CADBAS.Post;
  End;
end;


end.

