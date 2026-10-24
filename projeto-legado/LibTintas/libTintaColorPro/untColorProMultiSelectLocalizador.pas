unit untColorProMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TColorProMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TColorProMultiSelectLocalizador }

constructor TColorProMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   WANPRO_CADWAN            ' +
    ' WHERE WAN_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   WANPRO_CADWAN            ' +
    ' WHERE                      ' +
    ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
    ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
    ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ');

  Sqls.Add(
    ' SELECT ' +
    '   *    ' +
    ' FROM   ' +
    '   WANPRO_CADWAN             ' +
    ' WHERE                       ' +
    '   WAN_CODSEQ = :ITETIN      ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('WCP', TColorProMultiSelectLocalizador);

end.
