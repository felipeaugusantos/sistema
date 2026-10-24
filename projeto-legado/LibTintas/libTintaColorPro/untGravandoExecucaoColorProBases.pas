{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta ColorPro *}
{***********************************************************************AC*}
unit untGravandoExecucaoColorProBases;

interface

uses
  untAbstractGravandoExecucaoColorPro, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, XMLDoc, XMLIntf, UniClientDataSet, DB, TypInfo, StrUtils;

type
  TGravandoExecucaoColorProBases = class(TAbstractGravandoExecucaoColorPro)
  private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoColorProBases }

procedure TGravandoExecucaoColorProBases.Executar(const gravando: IGravando);
var
  qryDestino     : IDataSet;

  intQtdAtual    : Integer;
  intQtdRegistros: Integer;
  txtTonner      : TextFile;

  strLinha       : String;
  strLinBas      : String;
  strCodBas      : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath('Tonners')) Then
      Begin
        gravando.Texto := 'O Arquivo Tonners.txt não existe no caminho informado...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('WANPRO_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          intQtdAtual     := 1;
          intQtdRegistros := fTamArq(GetPath('Tonners'), gravando);

          AssignFile(txtTonner, GetPath('Tonners'));
          Reset(txtTonner);

          qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
          qryDestino.SQL := 'SELECT * FROM WANPRO_CADBAS';
          qryDestino.Open;

          While (Not Eof(txtTonner)) Do
          Begin
            if gravando.Status <> sgGravando then
              Exit;

            ReadLn(txtTonner, strLinha);

            strLinBas := Trim(Copy(strLinha, 01, 13));
            strCodBas := Trim(Copy(strLinha, 14, 20));

            If Not qryDestino.Locate('BAS_LINHA_;BAS_CODBAS', VarArrayOf([strLinBas, strCodBas]), []) Then
            Begin
              qryDestino.Insert;
              qryDestino.FieldByName('BAS_LINHA_').AsString := strLinBas;
              qryDestino.FieldByName('BAS_CODBAS').AsString := strCodBas;
              qryDestino.FieldByName('BAS_DESBAS').AsString := Trim(Copy(strLinha, 35, 110));
              qryDestino.FieldByName('BAS_PESESP').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Trim(Copy(strLinha, 167, 19)));
              qryDestino.FieldByName('BAS_EMBALA').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Trim(Copy(strLinha, 186, 19))) * 1000;
              qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
              qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WANPRO_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('BAS_PREVEN').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Trim(Copy(strLinha, 153, 12)));
              qryDestino.Post;
            End;

            gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
            intQtdAtual := intQtdAtual + 1;
          End;

          CloseFile(txtTonner);

        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          end;
        End;
      Finally

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

function TGravandoExecucaoColorProBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoColorProBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
