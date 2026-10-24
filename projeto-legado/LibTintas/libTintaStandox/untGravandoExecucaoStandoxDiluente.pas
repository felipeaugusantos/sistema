{**************************************************************************}
{* Classe responsável pela geração do cadastro de Diluentes da tinta Standox *}
{***********************************************************************AC*}
unit untGravandoExecucaoStandoxDiluente;

interface

uses
  untAbstractGravandoExecucaoStandox, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

type
  TGravandoExecucaoStandoxDiluente = class(TAbstractGravandoExecucaoStandox)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  const
    arrCodDil: Array[0..4] Of String[10] = ('MSB 10-20',
                                            'MSB 15-25',
                                            'MSB 25-35',
                                            'STBLCOATA',
                                            'STBLADJSL');

    arrCodigo: Array[0..4] Of String[12] = ('T44192002/10',
                                            'T24892002/10',
                                            'T82602002/10',
                                            'T00292000/1S',
                                            'T03012000/1S');

    arrDescri: Array[0..4] Of String[50] = ('Standox Thinner MSB 10-20',
                                            'Standox Thinner MSB 15-25',
                                            'Standox Thinner MSB 25-35',
                                            'STANDOBLUE BASECOAT VISCOSITY ADJUSTER',
                                            'STANDOBLUE VISCOSITY ADJUSTER SLOW');

    arrPesEsp: Array[0..4] Of Double = (0.88,
                                        0.85,
                                        0.87,
                                        1.01,
                                        1.01);

  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoStandoxDiluente }

procedure TGravandoExecucaoStandoxDiluente.Executar(const gravando: IGravando);
Var
  qryBases,
  qryDiluentes: IDataSet;
  intContador: Integer;
begin
  Gravando.Texto := 'Carregando dados do Cadastro de Diluentes...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Deletando Bases diluidas...';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;

  For intContador := 0 To Length(arrCodDil) - 1 Do
  Begin
    qryBases.SQL.Empty;
    qryBases.SQL := ' DELETE FROM DOX_CADBAS WHERE BAS_CODBAS = :BASDIL ';
    qryBases.ParamByName('BASDIL').AsString := String(arrCodDil[intContador]);
    qryBases.ExecSQL;
    Gravando.RegistrarProgresso(0, intContador, Length(arrCodDil));
  End;

  Gravando.Texto := 'Deletando Cadastro de Diluentes...';
  qryDiluentes := TAutcomTintaFactory.Get.fGetDataSet;
  qryDiluentes.SQL := '   DELETE FROM DOX_CADDIL  ';
  qryDiluentes.ExecSQL;
  qryDiluentes.SQL.Empty;

  Gravando.Texto := 'Verificando PROCOD...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  TAutcomTintaFactory.Get.fInsereProCod('DOX_CADDIL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Gravando Diluentes no Cadastro de Bases...';

  qryBases.SQL := ' SELECT * FROM DOX_CADBAS ';
  qryBases.Open;

  For intContador := 0 To Length(arrCodDil) - 1 Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryBases.Insert;
    qryBases.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryBases.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryBases.FieldByName('BAS_CODBAS').AsString := String(arrCodDil[intContador]);
    qryBases.FieldByName('BAS_DESBAS').AsString := String(arrDescri[intContador]);
    qryBases.FieldByName('BAS_PESESP').AsFloat  := arrPesEsp[intContador];

    If intContador <= 2 Then
      qryBases.FieldByName('BAS_EMBALA').AsFloat := 1000
    Else
      qryBases.FieldByName('BAS_EMBALA').AsFloat := 3500;

    qryBases.FieldByName('BAS_PESGRA').AsString := 'N';
    qryBases.Post;
    Gravando.RegistrarProgresso(0, intContador, Length(arrCodDil));
  End;

  Gravando.Texto := 'Processando Cadastro de Diluentes...';
  qryDiluentes.SQL := '   SELECT * FROM DOX_CADDIL WHERE FALSE    ';
  qryDiluentes.Open;

  For intContador := 0 To Length(arrCodDil) - 1 Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryDiluentes.Insert;
    qryDiluentes.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDIL', TAutcomTintaFactory.Get.GetCodEmp);
    qryDiluentes.FieldByName('DIL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDiluentes.FieldByName('DIL_CODDIL').AsString := String(arrCodDil[intContador]);
    qryDiluentes.FieldByName('DIL_DESCRI').AsString := String(arrDescri[intContador]);
    qryDiluentes.FieldByName('DIL_PESESP').AsFloat  := arrPesEsp[intContador];
    qryDiluentes.FieldByName('DIL_CODIGO').AsString := String(arrCodigo[intContador]);
    qryDiluentes.Post;
    Gravando.RegistrarProgresso(0, intContador, Length(arrCodDil));
  End;

end;

function TGravandoExecucaoStandoxDiluente.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Diluentes';
end;

end.
