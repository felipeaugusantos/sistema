{**************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta ColorPro *}
{***********************************************************************AC*}
unit untGravandoExecucaoColorProCores;

interface

uses
  untAbstractGravandoExecucaoColorPro, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, XMLDoc, XMLIntf, Variants,
  UniClientDataSet, Uni, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms;

type
  TGravandoExecucaoColorProCores = class(TAbstractGravandoExecucaoColorPro)
  private
    qryCadWanPro: TFDQuery;
    qryCadBas: IDataSet;
    qryWanPro_CodUni: TFDQuery;

    function fCriaQueryCores(): String;
    function fHabilitaDesabilitaKeys(blnHabilitar: Boolean): String;
    function fVerificaMd5KeyExistir(strMd5: String): Boolean;

    function fVarianteCor(strCodigo: String): String;

    function fCriaQueryLinhas : IDataSet;

    function fCriaQueryCodUni: String;
    function fCriaTabelaCodUni: String;
    procedure InsereCoresTabelaCodUni();

    function fCarregaCadastroBasesWandaPro(const gravando: IGravando): IDataSet;
    procedure VerificaDeletaMD5KEYDuplicado(const Gravando: IGravando);


    function fRetornaPreco11(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume: Double; Var fltVolumeMassa: Double): Double;

    function fRetornaPreco(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume: Double; Var fltVolumeMassa: Double): Double;

    function fRetornaPrecoPU(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume, fltQtdProduzir: Double; var fltVolumeMassa: Double): Double;

    function fRetDescLinha(strCodigo: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoColorProCores }


procedure TGravandoExecucaoColorProCores.VerificaDeletaMD5KEYDuplicado(
  const Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        WAN_MD5KEY       ' +
                '   FROM WANPRO_CADWAN    ' +
                '  GROUP BY WAN_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados WANPRO_CADWAN...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM WANPRO_CADWAN ' +
                    '  WHERE WAN_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('WAN_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;

  End;
end;

procedure TGravandoExecucaoColorProCores.Executar(const gravando: IGravando);
  Const
    TAM_EMBALAGEM_2POR1_BT100 = 618;
    TAM_EMBALAGEM_2POR1 = 640;
    TAM_EMBALAGEM_4POR1 = 750;
    TAM_EMBALAGEM_9POR2 = 750;
    ERROR_PRIMARY_KEY_INSERT = 1062;
var
    strLinWan: String;
    strMsgDil: String;

    intQtdAtual: Integer;
    intQtdRegistros: Integer;
    txtColors: TextFile;

    strLinAnterior    : String;
    strCodAnterior    : String;
    strAltAnterior    : String;
    strLinha          : String;
    strDesCorAnterior : String;
    strVerCorAnterior : String;

    qryCadLin: IDataSet;

    strLinPro: String; // cód da linha de produtos
    strCodCor: String; // código de cor
    strCodAkz: String; // código Akzo
    strDesCor: String; // descrição de cor
    strMontad: String; // montadora
    strVerCor: String; // versão da cor
    strAnoIni: String; // ano inicial
    strAnoFin: String; // ano final
    strDtaCad: String; // Data de cadastro
    strAltCor: String; // alternativa da cor

    strLinDil: String;
    strBasDil: String;
    fltFatBas: Double;
    fltPerDil: Double;

    intCamada: Integer;
    intContador: Integer;

    arrLinPig: Array[1..20] Of String;
    arrCodPig: Array[1..20] Of String;
    arrQtdPigCon: Array[1..20] Of Double;
    arrQtdPigDil: Array[1..20] Of Double;
    arrQtdPigDil4Por1: Array[1..20] Of Double;
    arrQtdPigDil9Por2: Array[1..20] Of Double;
    arrPorcen: Array[1..20] Of Double;

    fltTotDiluido: Double;
    fltTotDiluido2: Double;
    fltTotDiluido4: Double;
    fltTotConcent: Double;

    fltTamEmb2Por1: Double;
    fltTamEmb4Por1: Double;
    fltTamEmb9Por2: Double;
    fltVolTinner2Por1: Double;
    fltVolTinner4Por1: Double;
    fltVolTinner9Por2: Double;

    fltPerThinner2: Double;
    fltPerThinner4: Double;
    fltSomaR2: Double;
    fltSomaR4: Double;
    fltPEThinner: Double;
    strMD5: String;

    fltEmb2Por1: Double;
    fltEmb4por1: Double;
    fltEmb9Por2: Double;
    fltPerDil4Por1: Double;

    fltPerCen: Double;

    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltVolumeMassa: Double;
    fltPesoBase: Double;
    fltPreCusCon: Double;
    fltPreVenCon: Double;
    fltPreCusDil: Double;
    fltPreVenDil: Double;
    fltPreCusDil4Por1: Double;
    fltPreVenDil4Por1: Double;

    fltVolumeCon: Double;
    fltVolumeDil: Double;
    fltVolumeDil4Por1: Double;
    fltVolumeDil9Por2: Double;

    fltDivisorEmb2por1: Double;
    fltMultiplicadorEmb2por1: Double;
    fltMultiplicadorEmb9Por2: Double;
    fltDivisorEmb4por1: Double;
    fltDivisorEmb9Por2: Double;
    fltMultiplicadorEmb4por1: Double;

    blnCalcula2Por1: Boolean;
    blnCalcula4Por1: Boolean;
    blnCalcula9Por2: Boolean;


    //Otimização
    intContadorOtimizacao: Integer;
    intQtd: Integer;
begin
  pApagaTemporaria;

  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath('Tonners')) Then
      Begin
        gravando.Texto := 'O Arquivo Tonners.txt não existe no caminho informado...';
        gravando.Cancelar;
        Exit;
      End;

      If (Not fValidaPath('Layer')) Then
      Begin
        gravando.Texto := 'O Arquivo Layer.txt não existe no caminho informado...';
        gravando.Cancelar;
        Exit;
      End;

      If (Not fValidaPath('Colors')) Then
      Begin
        gravando.Texto := 'O Arquivo Colors.txt não existe no caminho informado...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      strLinWan := conf.fGet('LINWAN');

      strMsgDil := fMensagemLinhasDiluentes(strLinWan);

      If (Not TStrUtils.fEmptyStr(strMsgDil)) Then
      Begin
        strMsgDil := Copy(strMsgDil, 1, Length(strMsgDil));
        If TAutcomTintaFactory.Get.fMensagem('Informação', 'As seguintes linhas não estão com o diluente configurado: ' + strMsgDil + #13#10 + 'Deseja continuar?', ['&Sim', '&Não']) = 2 Then
        Begin
          gravando.Texto := 'As seguintes linhas não estão com o diluente configurado: ' + strMsgDil;
          gravando.Cancelar;
          Exit;
        End;
      End;

      //Selecionando as bases
      qryCadBas := fCarregaCadastroBasesWandaPro(gravando);

      if gravando.Status <> sgGravando then
        Exit;

      pCarregaFormulacoes(gravando);

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('WANPRO_CODUNI');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      //Criando a tabela de insert do coduni
      qryWanPro_CodUni := TFDQuery.Create(Nil);
      qryWanPro_CodUni.Connection := FDDatabase;

      qryWanPro_CodUni.SQL.Text := fCriaTabelaCodUni();
      qryWanPro_CodUni.ExecSQL;
      qryWanPro_CodUni.Close;
      qryWanPro_CodUni.SQL.Text := fCriaQueryCodUni;

      gravando.Texto := 'Limpando a Tabela de Unidades ...';

      gravando.Texto := 'Limpando WANPRO_CODUNI...';
      TAutcomTintaFactory.Get.TruncateTable('WANPRO_CODUNI');
      gravando.Texto := 'WANPRO_CODUNI limpa com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('WANPRO_CADWAN');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      //Criando a tabela de insert
      qryCadWanPro := TFDQuery.Create(Nil);
      qryCadWanPro.Connection := FDDatabase;
      qryCadWanPro.Close;
      qryCadWanPro.SQL.Clear();
      qryCadWanPro.SQL.Text := fHabilitaDesabilitaKeys(False);
      qryCadWanPro.ExecSQL;
      qryCadWanPro.SQL.Text := fCriaQueryCores();

      gravando.Texto := 'Limpando a Tabela de Cores ...';

      gravando.Texto := 'Limpando WANPRO_CADWAN...';
      TAutcomTintaFactory.Get.TruncateTable('WANPRO_CADWAN');
      gravando.Texto := 'WANPRO_CADWAN limpa com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      // Gravando a Tabela de Linha
      gravando.Texto := 'Limpando a Tabela de Linhas ...';

      gravando.Texto := 'Limpando WANPRO_CADLIN...';
      TAutcomTintaFactory.Get.TruncateTable('WANPRO_CADLIN');
      gravando.Texto := 'WANPRO_CADLIN limpa com sucesso!';

      gravando.Texto := 'Gerando o arquivo de linhas!';

      qryCadLin := fCriaQueryLinhas;
      qryCadLin.ExecSQL;

      gravando.Texto := 'Cadastro de linhas gerado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      intQtdAtual     := 1;
      intQtdRegistros := fTamArq(GetPath('Colors'), gravando);

      AssignFile(txtColors, GetPath('Colors'));
      Reset(txtColors);

      strLinAnterior := '';
      strCodAnterior := '';
      strAltAnterior := '';
      strDesCorAnterior := '';
      strVerCorAnterior := '';

      if gravando.Status <> sgGravando then
        Exit;

      Gravando.Texto := 'Cadastrando Unidades...';


      Try
        While (Not Eof(txtColors)) Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Exit;

          qryWanPro_CodUni.Params.ClearValues();
          qryWanPro_CodUni.Params.ArraySize := 30000;
          intQtd := 0;

          For intContadorOtimizacao := 0 To Pred(30000) Do
          Begin
            ReadLn(txtColors, strLinha);

            strLinPro := Trim(Copy(strLinha, 001, 010));
            strCodCor := Trim(Copy(strLinha, 011, 022));
            strCodAkz := Trim(Copy(strLinha, 033, 021));
            strAltCor := Trim(Copy(strLinha, 157, 006));
            strVerCor := Trim(Copy(strLinha, 124, 002));


            qryWanPro_CodUni.ParamByName('WANPRO_LINHA_').AsStrings[intContadorOtimizacao] := strLinPro;
            qryWanPro_CodUni.ParamByName('WANPRO_CODUNI').AsStrings[intContadorOtimizacao] := strCodCor;
            qryWanPro_CodUni.ParamByName('WANPRO_CODAKZ').AsStrings[intContadorOtimizacao] := strCodAkz;
            qryWanPro_CodUni.ParamByName('WANPRO_ALTERN').AsStrings[intContadorOtimizacao] := strAltCor;
            qryWanPro_CodUni.ParamByName('WANPRO_VERCOR').AsStrings[intContadorOtimizacao] := strVerCor;

            gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
            intQtdAtual := intQtdAtual + 1;
            Inc(intQtd);

            If Not Eof(txtColors) Then
              Continue
            Else
              Break;
          End;
          qryWanPro_CodUni.Execute(intQtd, 0);
        End;
      Finally
        InsereCoresTabelaCodUni();
        FreeAndNil(qryWanPro_CodUni);
      End;

      Reset(txtColors);
      intQtdAtual     := 1;
      gravando.Texto := 'Cadastrando tintas...';

      While (Not Eof(txtColors)) Do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        ReadLn(txtColors, strLinha);

        strLinPro := Trim(Copy(strLinha, 001, 010));
        strCodCor := Trim(Copy(strLinha, 011, 022));
        strCodAkz := Trim(Copy(strLinha, 033, 021));
        strDesCor := Trim(Copy(strLinha, 054, 041));
        strMontad := Trim(Copy(strLinha, 095, 029));
        strVerCor := Trim(Copy(strLinha, 124, 002));
        strAnoIni := Trim(Copy(strLinha, 126, 011));
        strAnoFin := Trim(Copy(strLinha, 137, 011));
        strDtaCad := Trim(Copy(strLinha, 148, 009));
        Insert('/', strDtaCad, 3);
        Insert('/', strDtaCad, 6);

        strAltCor := Trim(Copy(strLinha, 157, 006));

        If (Pos(TStrUtils.fStrZero(strLinPro, 3), strLinWan) <= 0) Then
        Begin
          gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
          intQtdAtual := intQtdAtual + 1;
          Continue;
        End;


        If (strLinAnterior    = strLinPro) And
           (strCodAnterior    = strCodAkz) And
           (strDesCorAnterior = strDesCor) And
           (strAltAnterior    = strAltCor) And
           (strVerCorAnterior = strVerCor)  Then
        Begin
          gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
          intQtdAtual := intQtdAtual + 1;
          Continue;
        End;

        strLinAnterior    := strLinPro;
        strCodAnterior    := strCodAkz;
        strAltAnterior    := strAltCor;
        strDesCorAnterior := strDesCor;
        strVerCorAnterior := strVerCor;

        pRetornaInfoLinha(strLinPro, strLinDil, strBasDil, fltFatBas, fltPerDil);

        If (Pos(TStrUtils.fStrZero(strLinPro,2), '08_58_59_13_72_') > 0) Then
          fltFatBas := 1;

        For intCamada := 1 To 3 Do
        Begin
          With qryLayer Do
          Begin
            Close;
            {********************************************}
            {* Linha 11 tem o cálculo em cima           *}
            {* dos valores da linha 1                   *}
            {*****************************************NC*}
            If (Pos(TStrUtils.fStrZero(strLinPro,2), '11_') > 0) Then
            Begin
              SQL.Text := 'SELECT      ' +
                     '  "11" Linha, CodAkazo, NumCamadas, CodPigmento, ' +
                     '  Percentual, Versao, Alternativa ' +
                     'FROM        ' +
                     '  TMP_LAYER ' +
                     'WHERE       ' +
                     '  Linha = :Linha AND             ' +
                     '  CodAkazo = :CodAkazo AND       ' +
                     '  Alternativa = :Alternativa AND ' +
                     '  NumCamadas = :CAMADA AND       ' +
                     '  Versao =  :VersaoCor           ';
              ParamByName('Linha').AsString := '1'
            End
            Else
            Begin
              SQL.Text := 'SELECT      ' +
                     '  *         ' +
                     'FROM        ' +
                     '  TMP_LAYER ' +
                     'WHERE       ' +
                     '  Linha       = :Linha AND       ' +
                     '  CodAkazo    = :CodAkazo AND    ' +
                     '  Alternativa = :Alternativa AND ' +
                     '  NumCamadas  = :CAMADA AND      ' +
                     '  Versao      = :VersaoCor       ';
              ParamByName('Linha').AsString := strLinPro;
            End;
            ParamByName('CodAkazo').AsString    := strCodAkz;
            ParamByName('Alternativa').AsString := strAltCor;
            ParamByName('CAMADA').AsInteger     := intCamada;
            ParamByName('VersaoCor').AsString   := strVerCor;
            Open;
          End;

          If qryLayer.RecordCount = 0 Then
            Break;

          For intContador := Low(arrCodPig) To High(arrCodPig) Do
          Begin
            arrLinPig[intContador] := '';
            arrCodPig[intContador] := '';
            arrQtdPigCon[intContador] := 0.0;
            arrQtdPigDil[intContador] := 0.0;
            arrQtdPigDil4Por1[intContador] := 0.0;
            arrQtdPigDil9Por2[intContador] := 0.0;
            arrPorcen[intContador] := 0.0;
          End;

          intContador  := 1;

          fltTotConcent  := 0.0;
          fltTotDiluido  := 0.0;
          fltTotDiluido2 := 0.0;
          fltTotDiluido4 := 0.0;
          fltSomaR2      := 0.0;
          fltSomaR4      := 0.0;
          fltPEThinner   := 0.0;

          {*******************************************}
          {* REALIZA CALCULO DO TOTAL DE % VOLUME    *}
          {****************************************MV*}
          While (Not qryLayer.Eof) Do
          Begin

            If (Not qryCadBas.Locate('Linha;Base',
              VarArrayOf([qryLayer.FieldByName('Linha').AsString, qryLayer.FieldByName('CodPigmento').AsString]), [])) Then
            Begin
              qryLayer.Next;
              Continue;
            End;

            If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '11_') > 0) Then
            begin
              If qryLayer.FieldByName('CodPigmento').AsString <> 'Q065' Then
                fltTotConcent := fltTotConcent + (((qryLayer.FieldByName('Percentual').AsFloat * 100) / (100 - 23))/qryCadBas.FieldByName('PesoEsp').AsFloat);
            end
            Else if (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_') > 0) Then
            begin
              fltTotConcent := fltTotConcent + (qryLayer.FieldByName('Percentual').AsFloat / qryCadBas.FieldByName('PesoEsp').AsFloat);

              fltSomaR2 := fltSomaR2 + qryLayer.FieldByName('Percentual').AsFloat;
              fltSomaR4 := fltSomaR4 + qryLayer.FieldByName('Percentual').AsFloat;
            end
            Else if qryCadBas.FieldByName('PesoEsp').AsFloat > 0 then
            begin
              fltTotDiluido := fltTotDiluido + ((qryLayer.FieldByName('Percentual').AsFloat * fltFatBas) / qryCadBas.FieldByName('PesoEsp').AsFloat);
              fltTotConcent := fltTotConcent + (qryLayer.FieldByName('Percentual').AsFloat / qryCadBas.FieldByName('PesoEsp').AsFloat);
            end;
            qryLayer.Next;
          End;

          If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_') > 0) Then
          begin
            If (Not TStrUtils.fEmptyStr(strLinDil)) And
               (qryCadBas.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
              fltPEThinner := qryCadBas.FieldByName('PesoEsp').AsFloat;

            fltSomaR2 := fltSomaR2 + 23.076;
            fltSomaR4 := fltSomaR4 + 25.000;

            fltPerThinner2    := (100 * 23.076) / fltSomaR2;
            fltPerThinner2    := (fltPerThinner2 * fltTotConcent * fltPEThinner) / (100 - fltPerThinner2);

            fltPerThinner4    := (100 * 25.000) / fltSomaR4;
            fltPerThinner4    := (fltPerThinner4 * fltTotConcent * fltPEThinner) / (100 - fltPerThinner4);

            qryLayer.First;
            While not qryLayer.Eof Do
            Begin
              If (Not qryCadBas.Locate('Linha;Base',
                VarArrayOf([qryLayer.FieldByName('Linha').AsString, qryLayer.FieldByName('CodPigmento').AsString]), [])) Then
              Begin
                qryLayer.Next;
                Continue;
              End;

              fltTotDiluido2 := fltTotDiluido2 + (qryLayer.FieldByName('Percentual').AsFloat / qryCadBas.FieldByName('PesoEsp').AsFloat);
              fltTotDiluido4 := fltTotDiluido4 + (qryLayer.FieldByName('Percentual').AsFloat / qryCadBas.FieldByName('PesoEsp').AsFloat);
              qryLayer.Next;
            End;

            fltTotDiluido2 := fltTotDiluido2 + (fltPerThinner2/fltPEThinner);
            fltTotDiluido4 := fltTotDiluido4 + (fltPerThinner4/fltPEThinner);
          end;

          If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '37_72_') <= 0) Then
          Begin
            If (Not TStrUtils.fEmptyStr(strLinDil))                                                                   And
               (qryCadBas.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
            Begin
              if qryCadBas.FieldByName('PesoEsp').AsFloat > 0 then
              begin
                fltTotDiluido := fltTotDiluido + (fltPerDil / qryCadBas.FieldByName('PesoEsp').AsFloat);
              end;
            End;
          End;

          qryLayer.First;

          {*******************************************}
          {* REALIZA CALCULO DO PREÇO DILUIDO        *}
          {****************************************MV*}
          fltVolTinner2Por1 := 0;
          fltVolTinner4Por1 := 0;
          fltVolTinner9Por2 := 0;
          fltEmb2por1       := 0;
          fltEmb4por1       := 0;
          fltEmb9Por2       := 0;
          fltTamEmb2Por1    := 0;
          fltTamEmb4Por1    := 0;
          fltTamEmb9Por2    := 0;

          While (Not qryLayer.Eof) Do
          Begin
            If (Not qryCadBas.Locate('Linha;Base',
              VarArrayOf([qryLayer.FieldByName('Linha').AsString, qryLayer.FieldByName('CodPigmento').AsString]), [])) Then
            Begin
              qryLayer.Next;
              Continue;
            End;

            {*********************************************}
            {* VERIFICA SE É WANDABASE, AUTOBASE (100:50,*}
            {* 100:80), WANDACAR OU WANDALAC, BT120      *}
            {******************************************MV*}
            If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '01_04_06_09_11_12_14_19_16_37_15_17_27_67_74_75_76_') > 0) Then
            Begin

              fltPerCen := qryLayer.FieldByName('Percentual').AsFloat;

              If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '11_') > 0) Then
              Begin
                If qryLayer.FieldByName('CodPigmento').AsString = 'Q065' Then
                  fltVolumeMassa := 0
                Else
                  fRetornaPreco11(fltPerCen,
                                  qryCadBas.FieldByName('PesoEsp').AsFloat,
                                  qryCadBas.FieldByName('TamEmbala').AsFloat,
                                  qryCadBas.FieldByName('Preco').AsFloat,
                                  fltTotConcent,
                                  fltVolumeMassa);
              End
              Else
                fRetornaPreco(fltPerCen,
                              qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('TamEmbala').AsFloat,
                              qryCadBas.FieldByName('Preco').AsFloat,
                              fltTotConcent,
                              fltVolumeMassa);

              fltVolumeCon := fltVolumeMassa;

              {**********************************************}
              {* WANDALAC, WANDACAR, SINGLE STAGE CONVERTER *}
              {* BT110 E BT130 NÃO TEM DILUIDO.             *}
              {*******************************************MV*}
              If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '01_04_12_14_19_16') > 0) Then
              Begin
                fRetornaPreco(fltPerCen * fltFatBas,
                              qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('TamEmbala').AsFloat,
                              qryCadBas.FieldByName('Preco').AsFloat,
                              fltTotDiluido,
                              fltVolumeMassa);
              End
              Else If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '37_') > 0) Then
              Begin
                fRetornaPrecoPU(fltPerCen * fltFatBas,
                                qryCadBas.FieldByName('PesoEsp').AsFloat,
                                qryCadBas.FieldByName('TamEmbala').AsFloat,
                                qryCadBas.FieldByName('Preco').AsFloat,
                                fltTotDiluido,
                                900*fltFatBas,
                                fltVolumeMassa);
              End
              Else
                fltVolumeMassa := 0.0;

              fltVolumeDil := fltVolumeMassa;

              arrLinPig[intContador]    := qryLayer.FieldByName('Linha').AsString;
              arrCodPig[intContador]    := qryLayer.FieldByName('CodPigmento').AsString;
              arrQtdPigCon[intContador] := fltVolumeCon;
              arrQtdPigDil[intContador] := fltVolumeDil;
              arrPorcen[intContador]    := qryLayer.FieldByName('Percentual').AsFloat;
            End
            Else
            Begin
              {*******************************************}
              {* AQUI SERÃO REALIZADOS OS CÁLCULOS DO    *}
              {* WANDA PU HS E WANDA PU MS               *}
              {* PU MS SÓ TEM 4:1                        *}
              {****************************************MV*}
              If TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2) = '13' Then
              Begin
                fltDivisorEmb2por1 := 1.10;
                fltDivisorEmb4por1 := 1.25;

                fltMultiplicadorEmb2Por1 := 10.00;
                fltMultiplicadorEmb4Por1 := 25.00;

                fltEmb2Por1 := TAM_EMBALAGEM_2POR1_BT100;
                fltEmb4por1 := TAM_EMBALAGEM_4POR1;

                fltTamEmb2Por1 := fltEmb2Por1 / fltDivisorEmb2por1;
                fltTamEmb4Por1 := fltEmb4por1 / fltDivisorEmb4por1;

                fltVolTinner2Por1 := (fltTamEmb2Por1 * fltMultiplicadorEmb2Por1 / 100.0);
                fltVolTinner4Por1 := (fltTamEmb4Por1 * fltMultiplicadorEmb4Por1 / 100.0);
              End
              Else If (TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2) = '72') Then
              Begin
                fltDivisorEmb9Por2 := 1.11;
                fltMultiplicadorEmb9Por2 := 11.1;
                fltEmb9Por2 := TAM_EMBALAGEM_9POR2;

                fltTamEmb9Por2 := fltEmb9Por2 / fltDivisorEmb9Por2;
                fltVolTinner9Por2 := (fltTamEmb9Por2 * fltMultiplicadorEmb9Por2 / 100.0);
              End
              Else If Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '58_59_') > 0 Then
              Begin
                fltEmb4por1 := TAM_EMBALAGEM_4POR1;
                fltMultiplicadorEmb4Por1 := 20;

                fltVolTinner2Por1 := 0.0;
                fltVolTinner4Por1 := (fltEmb4Por1 * fltMultiplicadorEmb4Por1 / 100.0);

                fltTamEmb2Por1 := 0;
                fltTamEmb4Por1 := fltEmb4por1 - fltVolTinner4Por1;
              End
              Else If TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2) = '08' Then
              Begin
                fltEmb2Por1 := TAM_EMBALAGEM_2POR1;
                fltEmb4por1 := TAM_EMBALAGEM_4POR1;

                fltVolTinner2Por1 := (fltEmb2Por1 * ((100 * 23.076) / fltSomaR2))/100;
                fltVolTinner4Por1 := (fltEmb4Por1 * ((100 * 25.000) / fltSomaR4))/100;
              End;

              fltPerCen    := qryLayer.FieldByName('Percentual').AsFloat;

              {*******************************************}
              {* CÁLCULO DO CONCENTRADO                  *}
              {****************************************MV*}
              fRetornaPrecoPU(fltPerCen,
                              qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('TamEmbala').AsFloat,
                              qryCadBas.FieldByName('Preco').AsFloat,
                              fltTotConcent,
                              900,
                              fltVolumeMassa);

              fltVolumeCon := fltVolumeMassa;
              {*******************************************}
              {* CÁLCULO DO DILUIDO 2:1                  *}
              {****************************************MV*}

              fltVolumeDil := 0.0;

              If Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_13_') > 0 Then
              Begin
                Try
                  blnCalcula2Por1 := Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_13_') > 0;
                  fRetornaPrecoPU(TAutcomTintaFactory.Get.IIF(blnCalcula2Por1, fltPerCen, 0),
                                    qryCadBas.FieldByName('PesoEsp').AsFloat,
                                    qryCadBas.FieldByName('TamEmbala').AsFloat,
                                    qryCadBas.FieldByName('Preco').AsFloat,
                                    TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido2, fltTotDiluido),
                                    TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltEmb2Por1, fltTamEmb2Por1),
                                    fltVolumeMassa);

                  fltVolumeDil := fltVolumeMassa;
                Except
                  fltVolumeDil := fltVolumeCon;
                End;

              End;
              {*******************************************}
              {* CÁLCULO DO DILUIDO 4:1                  *}
              {****************************************MV*}
              If Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_13_58_59_') > 0 Then
              Begin
                Try
                  blnCalcula4Por1 := Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_13_58_59_') > 0;
                  fRetornaPrecoPU(TAutcomTintaFactory.Get.IIF(blnCalcula4Por1, fltPerCen, 0),
                                  qryCadBas.FieldByName('PesoEsp').AsFloat,
                                  qryCadBas.FieldByName('TamEmbala').AsFloat,
                                  qryCadBas.FieldByName('Preco').AsFloat,
                                  TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido4, fltTotDiluido),
                                  TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltEmb4Por1, fltTamEmb4Por1),
                                  fltVolumeMassa);

                  fltVolumeDil4Por1 := fltVolumeMassa;
                Except
                  fltVolumeDil4Por1 := fltVolumeCon;
                End;
              End;

              {*******************************************}
              {* CÁLCULO DO 9:2                          *}
              {****************************************RG*}
              If Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '072_') > 0 Then
              Begin
                Try
                  blnCalcula9Por2 := Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '72_') > 0;
                  fRetornaPrecoPU(TAutcomTintaFactory.Get.IIF(blnCalcula9Por2, fltPerCen, 0),
                                  qryCadBas.FieldByName('PesoEsp').AsFloat,
                                  qryCadBas.FieldByName('TamEmbala').AsFloat,
                                  qryCadBas.FieldByName('Preco').AsFloat,
                                  fltTotDiluido,
                                  fltTamEmb9Por2,
                                  fltVolumeMassa);

                  fltVolumeDil9Por2 := fltVolumeMassa;
                Except
                  fltVolumeDil9Por2 := fltVolumeCon;
                End;
              End;


              arrLinPig[intContador]         := qryLayer.FieldByName('Linha').AsString;
              arrCodPig[intContador]         := qryLayer.FieldByName('CodPigmento').AsString;
              arrQtdPigCon[intContador]      := fltVolumeCon;
              arrQtdPigDil[intContador]      := fltVolumeDil;
              arrQtdPigDil4Por1[intContador] := fltVolumeDil4Por1;
              arrQtdPigDil9Por2[intContador] := fltVolumeDil9Por2;
              arrPorcen[intContador]         := qryLayer.FieldByName('Percentual').AsFloat;
            End;

            Inc(intContador);
            qryLayer.Next;
          End;

          {*******************************************}
          {* CALCULA O PREÇO E QUANTIDADE DO DILUENTE*}
          {****************************************MV*}
          fltVolumeMassa := 0.0;
          fltVolumeDil4Por1 := 0.0;
          fltVolumeDil9Por2 := 0.0;
          If (Not TStrUtils.fEmptyStr(strLinDil))                                                                   And
             (qryCadBas.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
          Begin

            {*******************************************}
            {* WANDABASE HS, AUTOBASE 100:50 E 100:80  *}
            {****************************************MV*}
            If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '01_04_12_14_19_16') > 0) Then
            Begin
              fRetornaPreco(fltPerDil,
                            qryCadBas.FieldByName('PesoEsp').AsFloat,
                            qryCadBas.FieldByName('TamEmbala').AsFloat,
                            qryCadBas.FieldByName('Preco').AsFloat,
                            fltTotDiluido,
                            fltVolumeMassa);
            End
            Else If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '37_') > 0) Then
            Begin
              fltVolumeMassa := (900 * fltPerDil / 100) * qryCadBas.FieldByName('PesoEsp').AsFloat;
              fltVolumeMassa := TFloatUtils.fTruncaFloat(fltVolumeMassa, 1);
            End
            Else If (Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_58_59_13') > 0) Then
            Begin
              fRetornaPrecoPU(fltVolTinner2Por1 * qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('TamEmbala').AsFloat,
                              qryCadBas.FieldByName('Preco').AsFloat,
                              TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido2, fltTotDiluido),
                              0.0,
                              fltVolumeMassa);

              fRetornaPrecoPU(fltVolTinner4Por1 * qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('TamEmbala').AsFloat,
                              qryCadBas.FieldByName('Preco').AsFloat,
                              TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido4, fltTotDiluido),
                              0.0,
                              fltVolumeDil4Por1);
            End
            {*******************************************}
            {* TECH FLEET PU - BT362                   *}
            {****************************************RG*}
            Else If Pos(TStrUtils.fStrZero(qryLayer.FieldByName('Linha').AsString, 3), '072_') > 0 Then
            Begin
              fRetornaPrecoPU(fltVolTinner9Por2 * qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('PesoEsp').AsFloat,
                              qryCadBas.FieldByName('TamEmbala').AsFloat,
                              qryCadBas.FieldByName('Preco').AsFloat,
                              fltTotDiluido,
                              0.0,
                              fltVolumeDil9Por2);
            End;

            arrLinPig[intContador]         := strLinDil;
            arrCodPig[intContador]         := strBasDil;
            arrQtdPigCon[intContador]      := 0.0;
            arrQtdPigDil[intContador]      := fltVolumeMassa;
            arrQtdPigDil4Por1[intContador] := fltVolumeDil4Por1;
            arrQtdPigDil9Por2[intContador] := fltVolumeDil9Por2;
            arrPorcen[intContador]         := 0.0;


          End;

          qryCadWanPro.Params.ClearValues();
          qryCadWanPro.Params.ArraySize := 1;

          qryCadWanPro.ParamByName('WAN_CODSEQ').AsStrings[0]  := TStrUtils.fStrZero(intQtdAtual, 6);
          qryCadWanPro.ParamByName('WAN_LINHA_').AsStrings[0]  := strLinPro;
          qryCadWanPro.ParamByName('WAN_NOMLIN').AsStrings[0] :=  fRetDescLinha(strLinPro);
          qryCadWanPro.ParamByName('WAN_CODAKZ').AsStrings[0]  := strCodAkz;
          qryCadWanPro.ParamByName('WAN_ALTERN').AsStrings[0]  := strAltCor;
          qryCadWanPro.ParamByName('WAN_DESCRI').AsStrings[0]  := AnsiUpperCase(strDesCor);
          qryCadWanPro.ParamByName('WAN_MONTAD').AsStrings[0]  := AnsiUpperCase(strMontad);
          qryCadWanPro.ParamByName('WAN_ANOINI').AsStrings[0]  := strAnoIni;
          qryCadWanPro.ParamByName('WAN_ANOFIN').AsStrings[0]  := strAnoFin;
          qryCadWanPro.ParamByName('WAN_CODEMP').AsStrings[0]  := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadWanPro.ParamByName('AUTOINCREM').AsStrings[0]  := TAutcomTintaFactory.Get.fRetAutoIncrem('WANPRO_CADWAN', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadWanPro.ParamByName('WAN_CAMADA').AsIntegers[0] := intCamada;
          qryCadWanPro.ParamByName('WAN_VERCOR').AsStrings[0]  := strVerCor;
          qryCadWanPro.ParamByName('WAN_ATIVO_').AsStrings[0]  := 'S';
          qryCadWanPro.ParamByName('WAN_VARIAN').AsStrings[0]  := fVarianteCor(strCodAkz);

          strMD5 := '';
          strMD5 := strCodCor +
                    qryCadWanPro.ParamByName('WAN_LINHA_').AsStrings[0] +
                    qryCadWanPro.ParamByName('WAN_CODAKZ').AsStrings[0] +
                    qryCadWanPro.ParamByName('WAN_ALTERN').AsStrings[0] +
                    qryCadWanPro.ParamByName('WAN_MONTAD').AsStrings[0] +
                    qryCadWanPro.ParamByName('WAN_CAMADA').AsStrings[0] +
                    qryCadWanPro.ParamByName('WAN_DESCRI').AsStrings[0] +
                    qryCadWanPro.ParamByName('WAN_VERCOR').AsStrings[0];

          strMD5 := GetMD5(strMd5);

          qryCadWanPro.ParamByName('WAN_MD5KEY').AsStrings[0] := strMD5;

          For intContador := 1 To 20 Do
          Begin
            {********************************************}
            {* Linha 11, troca o Q065 da linha 1        *}
            {* pelo Q080 da linha 11                    *}
            {* Q080 só concentrado, equivale a  50% do  *}
            {* volume total * peso específico           *}
            {*****************************************NC*}
            If (Pos(TStrUtils.fStrZero(strLinPro,2), '11_') > 0) And (arrCodPig[intContador] = 'Q065') Then
            Begin
              qryCadWanPro.ParamByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsStrings[0] := arrLinPig[intContador];  // LIN. PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsStrings[0] := 'Q080';                  // CÓD. PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := 450 * 0.996;             // QTD. PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := 0;                       // QTD. DILUIDA / 2:1 PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := 0;                       // QTD. DILUIDA / 4:1 PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := 0;                       // QTD. DILUIDA / 9:2 PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_PORC' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := 0;                       // PORCENTAGEM DE CADA BASE UTILIZADA
            End
            Else
            Begin
              qryCadWanPro.ParamByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsStrings[0] := arrLinPig[intContador];         // LIN. PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsStrings[0] := arrCodPig[intContador];         // CÓD. PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0] := arrQtdPigCon[intContador];      // QTD. PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := arrQtdPigDil[intContador];      // QTD. DILUIDA / 2:1 PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := arrQtdPigDil4Por1[intContador]; // QTD. DILUIDA / 4:1 PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := arrQtdPigDil9Por2[intContador]; // QTD. DILUIDA / 9:2 PIGMENTO XX
              qryCadWanPro.ParamByName('WAN_PORC' + TStrUtils.fStrZero(intContador, 2)).AsFloats[0]  := arrPorcen[intContador];         // PORCENTAGEM DE CADA BASE UTILIZADA
            End;
          End;

          Try
            If fVerificaMd5KeyExistir(strMD5) Then
              qryCadWanPro.Execute(1, 0);
          Except
            On E: Exception Do
            Begin
              gravando.Texto := 'Erro gravando cadastro de unidades [WANPRO_CODWAN]';
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              Raise;
            End;
          End;
        End;

        gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
        intQtdAtual := intQtdAtual + 1;
      End;

      VerificaDeletaMD5KEYDuplicado(Gravando);
      qryCadWanPro.SQL.Text := fHabilitaDesabilitaKeys(True);
      qryCadWanPro.ExecSQL;

      FreeAndNil(qryCadWanPro);
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoColorProCores.fCarregaCadastroBasesWandaPro(
  const gravando: IGravando): IDataSet;
begin
  gravando.Texto := 'Carregando cadastro de Bases ...';

  Result := TAutcomTintaFactory.Get.fGetDataSet;

  Result.SQL := 'SELECT                           ' +
                '  BAS_LINHA_ AS Linha,           ' +
                '  BAS_CODBAS AS Base,            ' +
                '  BAS_DESBAS AS Descricao,       ' +
                '  " "        AS Status,          ' +
                '  0.0        AS Preco,           ' +
                '  BAS_PESESP AS PesoEsp,         ' +
                '  BAS_EMBALA * 1000 AS TamEmbala ' +
                'FROM                             ' +
                '  WANPRO_CADBAS                  ';
  Result.Open;

  If Result.IsEmpty Then
  Begin
    gravando.Texto := 'O Cadastro de Bases está vazio, favor gerar o cadastro de bases ...';
    gravando.Cancelar;
    Exit;
  End;

  gravando.Texto := 'Cadastro de bases carregando com sucesso ...';
end;

function TGravandoExecucaoColorProCores.fCriaQueryCodUni: String;
begin
  Result :=                 ' INSERT INTO WANPRO_CODUNI1  ' +
                            '           (WANPRO_CODUNI,  ' +
                            '            WANPRO_CODAKZ,  ' +
                            '            WANPRO_ALTERN,  ' +
                            '            WANPRO_LINHA_,  ' +
                            '            WANPRO_VERCOR)  ' +

                            ' VALUES   (:WANPRO_CODUNI,  ' +
                            '           :WANPRO_CODAKZ,  ' +
                            '           :WANPRO_ALTERN,  ' +
                            '           :WANPRO_LINHA_,  ' +
                            '           :WANPRO_VERCOR)  ';
end;

function TGravandoExecucaoColorProCores.fCriaQueryCores: String;
var
  intForm: Integer;
begin
  Result :=                 ' INSERT INTO WANPRO_CADWAN  ' +
                            '           (WAN_CODSEQ,  ' +
                            '            WAN_LINHA_,  ' +
                            '            WAN_NOMLIN,  ' +
                            '            WAN_CODAKZ,  ' +
                            '            WAN_ALTERN,  ' +
                            '            WAN_DESCRI,  ' +
                            '            WAN_MONTAD,  ' +
                            '            WAN_ANOINI,  ' +
                            '            WAN_ANOFIN,  ' +
                            '            WAN_CODEMP,  ' +
                            '            AUTOINCREM,  ' +
                            '            WAN_CAMADA,  ' +
                            '            WAN_VERCOR,  ' +
                            '            WAN_ATIVO_,  ' +
                            '            WAN_VARIAN,  ';

  For intForm := 1 To 20 Do
  Begin
    Result := Result  +         '        WAN_LINC' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        WAN_CODC' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        WAN_QCON' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        WAN_QD21' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        WAN_QD41' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        WAN_QD92' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        WAN_PORC' + TStrUtils.fStrZero(intForm, 2) + ', ';
  End;

  Result := Result  +         '          WAN_MD5KEY)  ' +
                              ' VALUES (:WAN_CODSEQ,  ' +
                              '         :WAN_LINHA_,  ' +
                              '         :WAN_NOMLIN,  ' +
                              '         :WAN_CODAKZ,  ' +
                              '         :WAN_ALTERN,  ' +
                              '         :WAN_DESCRI,  ' +
                              '         :WAN_MONTAD,  ' +
                              '         :WAN_ANOINI,  ' +
                              '         :WAN_ANOFIN,  ' +
                              '         :WAN_CODEMP,  ' +
                              '         :AUTOINCREM,  ' +
                              '         :WAN_CAMADA,  ' +
                              '         :WAN_VERCOR,  ' +
                              '         :WAN_ATIVO_,  ' +
                              '         :WAN_VARIAN,  ';

    For intForm := 1 To 20 Do
    Begin
      Result := Result  +         '     :WAN_LINC' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :WAN_CODC' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :WAN_QCON' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :WAN_QD21' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :WAN_QD41' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :WAN_QD92' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                  '     :WAN_PORC' + TStrUtils.fStrZero(intForm, 2) + ', ';
    End;

    Result := Result  +           '       :WAN_MD5KEY); ';
end;

function TGravandoExecucaoColorProCores.fCriaQueryLinhas: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;

  Result.SQL :=
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("1"  , "AUTOBASE PLUS 100:50");          '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("4"  , "WANDABASE HS");                  '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("6"  , "WANDALAC");                      '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("8"  , "WANDA PU HS");                   '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("9"  , "WANDACAR");                      '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("11" , "SINGLE STAGE CONVERTER");        '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("12" , "AUTOBASE PLUS BASELINE 100:80"); '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("13" , "AUTOCOAT BT100");                '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("14" , "AUTOBASE PLUS 100:80");          '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("15" , "AUTOCOAT BT110");                '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("16" , "AUTOCOAT BT120");                '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("17" , "AUTOCOAT BT130");                '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("19" , "AUTOBASE PLUS BASELINE 100:50"); '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("27" , "AUTOWAVE MM");                   '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("67" , "AUTOWAVE MM 2.0");               '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("58" , "WANDA PU MS");                   '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("59" , "AUTOCOAT BT90");                 '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("72" , "TECH FLEET PU");                 '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("74" , "TECH FLEET EPOXY");              '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("75" , "TECH FLEET SINTETICO");          '+
    ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("76" , "TECH FLEET LACA");               ';
end;

function TGravandoExecucaoColorProCores.fCriaTabelaCodUni: String;
begin
  Result :=  'CREATE TABLE WANPRO_CODUNI1 (' +
             ' WANPRO_CODUNI VARCHAR(22), ' +
             ' WANPRO_CODAKZ VARCHAR(21), ' +
             ' WANPRO_ALTERN CHAR(3),     ' +
             ' WANPRO_LINHA_ CHAR(3),     ' +
             ' WANPRO_VERCOR CHAR(3),     ' +
             ' KEY IDX_WANPRO_CODUNI_01 (WANPRO_CODAKZ, WANPRO_ALTERN)) ';
end;

function TGravandoExecucaoColorProCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoColorProCores.fHabilitaDesabilitaKeys(
  blnHabilitar: Boolean): String;
begin
  If blnHabilitar Then
    Result := 'ALTER TABLE WANPRO_CADWAN ENABLE KEYS'
  Else
    Result := 'ALTER TABLE WANPRO_CADWAN DISABLE KEYS';
end;

function TGravandoExecucaoColorProCores.fRetDescLinha(strCodigo: String): String;
Var
  QryAux : IDataSet;
Begin
   QryAux := TAutcomTintaFactory.Get.fGetDataSet;
   QryAux.SQL := 'SELECT WAN_NOMLIN '+
                 '  FROM WANPRO_CADLIN '+
                 ' WHERE WAN_CODLIN = :CODLIN ';
   QryAux.ParamByName('CODLIN').AsString := strCodigo;
   QryAux.Open;

   Result := QryAux.FieldByName('WAN_NOMLIN').AsString;
end;

function TGravandoExecucaoColorProCores.fRetornaPreco(fltPerCen, fltPesEsp,
  fltEmbala, fltPrePig, fltTotalPerVolume: Double;
  var fltVolumeMassa: Double): Double;
  Var
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltPesoBase: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerVolume   := fltPerCen / fltPesEsp;
  fltVolumeLitro := fltPerVolume * 900 / fltTotalPerVolume;
  fltVolumeMassa := TFloatUtils.fFormataFloat(fltVolumeLitro * fltPesEsp, 1);
  fltPesoBase    := TFloatUtils.fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := TFloatUtils.fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TGravandoExecucaoColorProCores.fRetornaPreco11(fltPerCen, fltPesEsp,
  fltEmbala, fltPrePig, fltTotalPerVolume: Double;
  var fltVolumeMassa: Double): Double;
  Var
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltPesoBase: Double;
    fltPerBases: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerBases    := fltPerCen * 100 / (100 - 23);
  fltPerVolume   := fltPerBases  / fltPesEsp;
  fltVolumeLitro := (450 * fltPerVolume)/ fltTotalPerVolume;
  fltVolumeMassa := TFloatUtils.fFormataFloat(fltVolumeLitro * fltPesEsp, 1);
  fltPesoBase    := TFloatUtils.fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := TFloatUtils.fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TGravandoExecucaoColorProCores.fRetornaPrecoPU(fltPerCen, fltPesEsp,
  fltEmbala, fltPrePig, fltTotalPerVolume, fltQtdProduzir: Double;
  var fltVolumeMassa: Double): Double;
  Var
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltPesoBase: Double;
begin

  fltPerCen      := fltPerCen;
  fltPerVolume   := fltPerCen / fltPesEsp;
  fltVolumeLitro := fltPerVolume * fltQtdProduzir / fltTotalPerVolume;

  {*******************************************}
  {* QUANDO É O CALCULO DO TINNER, JÁ TEM A  *}
  {* QUANTIDADE EM MASSA                     *}
  {****************************************MV*}
  If (fltQtdProduzir = 0.0) Then
    fltVolumeMassa := TFloatUtils.fFormataFloat(fltPerCen,1)
  Else
    fltVolumeMassa := TFloatUtils.fFormataFloat(fltVolumeLitro * fltPesEsp, 1);

  fltPesoBase    := TFloatUtils.fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := TFloatUtils.fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TGravandoExecucaoColorProCores.fVarianteCor(strCodigo: String): String;
Var
  intP: Integer;
  strCodigoNovo: String;
begin
  Result := '';

  IntP := Pos('(', strCodigo);

  If intP = 0 Then
  Begin
    Result := 'FÓRMULA PADRÃO';
    Exit;
  End;

  strCodigoNovo := Copy(strCodigo, intP, 4);
  IntP := Pos(')', strCodigoNovo);

  strCodigoNovo := Copy(strCodigoNovo, 1, intP);

  If strCodigoNovo = '(G)' Then
    Result := 'COR MAIS ESVERDEADA COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(R)' Then
    Result := 'COR MAIS AVERMELHADA COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(Y)' Then
    Result := 'COR MAIS AMARELADA COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(B)' Then
    Result := 'COR MAIS AZULADA COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(L)' Then
    Result := 'COR MAIS CLARA COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(D)' Then
    Result := 'COR MAIS ESCURA COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(F)' Then
    Result := 'COR COM O ALUMÍNIO MAIS FINO COMPARADA AO PADRÃO'
  Else If strCodigoNovo = '(C)' Then
    Result := 'COR COM O ALUMÍNIO MAIS GROSSO COMPARADA AO PADRÃO'
  Else If (strCodigoNovo = '(G1)') Or (strCodigoNovo = '(G2)') Or (strCodigoNovo = '(G3)') Or (strCodigoNovo = '(G4)') Then
    Result := 'COR COM MAIOR INTENSIDADE DE VERDE'
  Else If (strCodigoNovo = '(R1)') Or (strCodigoNovo = '(R2)') Or (strCodigoNovo = '(R3)') Or (strCodigoNovo = '(R4)') Then
    Result := 'COR COM MAIOR INTENSIDADE DE VERMELHO'
  Else If (strCodigoNovo = '(Y1)') Or (strCodigoNovo = '(Y2)') Or (strCodigoNovo = '(Y3)') Or (strCodigoNovo = '(Y4)') Then
    Result := 'COR COM MAIOR INTENSIDADE DE AMARELO'
  Else If (strCodigoNovo = '(B1)') Or (strCodigoNovo = '(B2)') Or (strCodigoNovo = '(B3)') Or (strCodigoNovo = '(B4)') Then
    Result := 'COR COM MAIOR INTENSIDADE DE AZUL'
  Else If (strCodigoNovo = '(L1)') Or (strCodigoNovo = '(L2)') Or (strCodigoNovo = '(L3)') Or (strCodigoNovo = '(L4)') Then
    Result := 'COR COM MENOR INTENSIDADE (MAIS CLARA)'
  Else If (strCodigoNovo = '(D1)') Or (strCodigoNovo = '(D2)') Or (strCodigoNovo = '(D3)') Or (strCodigoNovo = '(D4)') Then
    Result := 'COR COM MAIOR INTENSIDADE (MAIS ESCURA)'
  Else If (strCodigoNovo = '(F1)') Or (strCodigoNovo = '(F2)') Or (strCodigoNovo = '(F3)') Or (strCodigoNovo = '(F4)') Then
    Result := 'COR COM ALUMÍNIO MAIS FINO'
  Else If (strCodigoNovo = '(C1)') Or (strCodigoNovo = '(C2)') Or (strCodigoNovo = '(C3)') Or (strCodigoNovo = '(C4)') Then
    Result := 'COR COM ALUMÍNIO MAIS GROSSO';
end;

function TGravandoExecucaoColorProCores.fVerificaMd5KeyExistir(
  strMd5: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM WANPRO_CADWAN WHERE WAN_MD5KEY = :MD5KEY    ';
  qryGen.ParamByName('MD5KEY').AsString := strMd5;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TGravandoExecucaoColorProCores.InsereCoresTabelaCodUni;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' INSERT INTO WANPRO_CODUNI SELECT DISTINCT * FROM WANPRO_CODUNI1;  ';
  qryGen.ExecSQL;
end;

end.
